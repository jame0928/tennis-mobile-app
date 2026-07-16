import 'dart:convert';

import 'package:http/http.dart' as http;

import '../auth/token_provider.dart';
import '../telemetry/safe_telemetry.dart';
import 'api_exception.dart';
import 'api_response.dart';
import 'pagination_meta.dart';
import 'payload_policy.dart';

class ApiClient {
  ApiClient({
    required this.baseUrl,
    required this.httpClient,
    required this.tokenProvider,
    required this.telemetry,
    PayloadPolicy? payloadPolicy,
  }) : payloadPolicy = payloadPolicy ?? const PayloadPolicy();

  final String baseUrl;
  final http.Client httpClient;
  final TokenProvider tokenProvider;
  final SafeTelemetry telemetry;
  final PayloadPolicy payloadPolicy;

  Future<ApiResponse<dynamic>> get(
    String path, {
    Map<String, String>? query,
    bool authenticated = true,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    final response = await httpClient.get(
      uri,
      headers: await _headers(authenticated: authenticated),
    );
    return _parseEnvelope(response, endpoint: path);
  }

  Future<ApiResponse<dynamic>> post(
    String path, {
    required Map<String, dynamic> body,
    bool authenticated = true,
  }) async {
    payloadPolicy.validatePrivatePayload(path: path, body: body);
    final response = await httpClient.post(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(authenticated: authenticated),
      body: jsonEncode(body),
    );
    return _parseEnvelope(response, endpoint: path);
  }

  Future<ApiResponse<dynamic>> patch(
    String path, {
    required Map<String, dynamic> body,
    bool authenticated = true,
  }) async {
    payloadPolicy.validatePrivatePayload(path: path, body: body);
    final response = await httpClient.patch(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(authenticated: authenticated),
      body: jsonEncode(body),
    );
    return _parseEnvelope(response, endpoint: path);
  }

  Future<ApiResponse<dynamic>> delete(
    String path, {
    bool authenticated = true,
  }) async {
    final response = await httpClient.delete(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(authenticated: authenticated),
    );
    return _parseEnvelope(response, endpoint: path);
  }

  Future<Map<String, String>> _headers({required bool authenticated}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (authenticated) {
      final token = await tokenProvider.readAccessToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  ApiResponse<dynamic> _parseEnvelope(
    http.Response response, {
    required String endpoint,
  }) {
    Map<String, dynamic> json;
    try {
      if (response.body.trim().isEmpty) {
        throw const FormatException('Empty response body');
      }
      json = jsonDecode(response.body) as Map<String, dynamic>;
    } on FormatException {
      final exception = ApiException(
        code: 'INTERNAL_ERROR',
        message: 'Invalid API response format',
        statusCode: response.statusCode,
      );
      telemetry.recordApiFailure(endpoint: endpoint, code: exception.code);
      throw exception;
    }

    final success = (json['success'] as bool?) ?? false;

    if (!success) {
      final error = json['error'] as Map<String, dynamic>?;
      final exception = ApiException(
        code: (error?['code'] as String?) ?? 'INTERNAL_ERROR',
        message: (error?['message'] as String?) ?? 'Unknown API error',
        statusCode: response.statusCode,
        requestId: json['request_id'] as String?,
      );
      telemetry.recordApiFailure(
        endpoint: endpoint,
        code: exception.code,
        requestId: exception.requestId,
      );
      throw exception;
    }

    return ApiResponse<dynamic>(
      data: json['data'],
      meta: PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>?),
    );
  }
}
