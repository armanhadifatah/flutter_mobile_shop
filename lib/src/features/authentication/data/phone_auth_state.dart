enum PhoneAuthStatus {
  initial,
  codeSent,
  codeResend,
  verificationCompleted,
  verificationFailed,
  autoRetrievalTimeout,
  signInFailed,
  signInSuccessful,
}

class PhoneAuthState {
  final PhoneAuthStatus status;
  final String? verificationId;
  final String? errorMessage;

  PhoneAuthState({
    required this.status,
    this.verificationId,
    this.errorMessage,
  });
}
