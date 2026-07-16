import 'package:flutter/foundation.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../core/state/view_state.dart';
import '../domain/entities/profile.dart';
import '../domain/usecases/get_profile.dart';
import '../domain/usecases/update_profile.dart';

class ProfileController extends ChangeNotifier {
  ProfileController({
    required this.getProfile,
    required this.updateProfile,
    required this.errorMapper,
  });

  final GetProfile getProfile;
  final UpdateProfile updateProfile;
  final ErrorMapper errorMapper;

  ViewState<Profile> state = ViewState.idle();

  Future<void> load() async {
    state = ViewState.loading();
    notifyListeners();
    try {
      final profile = await getProfile();
      state = ViewState.success(profile);
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      state = ViewState.failure(failure.message, requestId: failure.requestId);
    }
    notifyListeners();
  }

  Future<void> save({
    required String firstName,
    required String lastName,
    String? displayName,
    String? phone,
  }) async {
    state = ViewState.loading();
    notifyListeners();
    try {
      final profile = await updateProfile(
        firstName: firstName,
        lastName: lastName,
        displayName: displayName,
        phone: phone,
      );
      state = ViewState.success(profile);
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      state = ViewState.failure(failure.message, requestId: failure.requestId);
    }
    notifyListeners();
  }
}
