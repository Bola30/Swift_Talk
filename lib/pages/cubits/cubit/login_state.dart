part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
   String errorMessage;

  LoginFailure(this.errorMessage);
}

class LoginObscurePasswordToggled extends LoginState {
  final bool obscurePassword;

  LoginObscurePasswordToggled(this.obscurePassword);
}