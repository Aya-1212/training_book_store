class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class RegisterSucessState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState({required this.error});
}
