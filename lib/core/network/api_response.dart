import 'pagination_meta.dart';

class ApiResponse<T> {
  const ApiResponse({required this.data, required this.meta});

  final T data;
  final PaginationMeta meta;
}
