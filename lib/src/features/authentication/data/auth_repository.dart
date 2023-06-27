import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/app_user.dart';
import 'firebase_app_user.dart';
import 'phone_auth_state.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthStatus,
            {String? verificationId, String? error})
        updateState,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-resolution happened
        updateState(PhoneAuthStatus.verificationCompleted);
        try {
          await _auth.signInWithCredential(credential);
          updateState(PhoneAuthStatus.signInSuccessful);
        } catch (e) {
          updateState(PhoneAuthStatus.signInFailed, error: e.toString());
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        // Verification has failed
        updateState(PhoneAuthStatus.verificationFailed, error: e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Code sent
        updateState(PhoneAuthStatus.codeSent, verificationId: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Code auto-retrieval timeout
        updateState(PhoneAuthStatus.autoRetrievalTimeout,
            verificationId: verificationId);
      },
    );
  }

  Future<void> signInWithCode(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
    } catch (e) {
      throw FirebaseAuthException(message: e.toString(), code: 'INVALID_CODE');
    }
  }

  AppUser? get currentUser => _convertUser(_auth.currentUser);

  /// Helper method to convert a [User] to an [AppUser]
  AppUser? _convertUser(User? user) =>
      user != null ? FirebaseAppUser(user) : null;

  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().map(_convertUser);
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
