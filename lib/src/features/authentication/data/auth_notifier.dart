import 'package:mobile_shop/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'phone_auth_state.dart';

part 'auth_notifier.g.dart';

@Riverpod()
class AuthNotifier extends _$AuthNotifier {
  @override
  PhoneAuthState build() {
    return PhoneAuthState(status: PhoneAuthStatus.initial);
  }

  void verifyPhoneNumber(String phoneNumber) async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      updateState: _updateState,
    );
  }

  void _updateState(PhoneAuthStatus status,
      {String? verificationId, String? error}) {
    state = PhoneAuthState(
      status: status,
      verificationId: verificationId,
      errorMessage: error,
    );
  }

  void signInWithCode(String smsCode) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);

      await authRepository.signInWithCode(state.verificationId!, smsCode);
      _updateState(PhoneAuthStatus.signInSuccessful);
    } catch (e) {
      _updateState(PhoneAuthStatus.signInFailed, error: e.toString());
    }
  }
}
