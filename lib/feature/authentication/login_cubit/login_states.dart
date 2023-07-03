import '../../../model/login_model.dart';

abstract class SignStates {}

class LoginInitialState extends SignStates {}

class ChangeVisibilityState extends SignStates {}

class LoginLoadingState extends SignStates {}

class LoginSuccessState extends SignStates {
  late String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends SignStates {}

class RegisterLoadingState extends SignStates {}

class RegisterSuccessState extends SignStates {
  late String uId;

  RegisterSuccessState(this.uId);
}

class RegisterErrorState extends SignStates {}

class CreateUserLoadingState extends SignStates {}

class CreateUserSuccessState extends SignStates {
  final String uId;
  CreateUserSuccessState(this.uId);
}

class CreateUserErrorState extends SignStates {}
