import 'package:polywin/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  LoginSuccessState(this.loginModel);
  final LoginModel loginModel;
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}


