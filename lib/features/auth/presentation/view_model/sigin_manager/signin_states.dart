class SignInStates {}

class SignInInitState extends SignInStates {}

class SignInSucessState extends SignInStates {}

class SignInErrorState extends SignInStates {
  final String error;
  SignInErrorState({required this.error});
}

class SignInLoadingState extends SignInStates {}

//ForgetPasswordStates

class ForgetPasswordSucessState extends SignInStates {}

class ForgetPasswordLoadingState extends SignInStates {}

class ForgetPasswordErrorState extends SignInStates {
  final String error;

  ForgetPasswordErrorState({required this.error});
}

//verify code

class VerifyCodeSucessState extends SignInStates {}

class VerifyCodeLoadingState extends SignInStates {}

class VerifyCodeErrorState extends SignInStates {
  final String error;

  VerifyCodeErrorState({required this.error});
}

////reset password

class ResetPasswordSucessState extends SignInStates {}

class ResetPasswordLoadingState extends SignInStates {}

class ResetPasswordErrorState extends SignInStates {
  final String error;
  ResetPasswordErrorState({required this.error});
}

//resend verify code

// class ResendVerifyCodeSucessState extends SignInStates {}

// class ResendVerifyCodeLoadingState extends SignInStates {}

// class ResendVerifyCodeErrorState extends SignInStates {
//   final String error;

//   ResendVerifyCodeErrorState({required this.error});
// }
