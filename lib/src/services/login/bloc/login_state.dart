import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {
  const LoginInitState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState();
}

class LoginFailedState extends LoginState {
  const LoginFailedState(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class LoginCredentialsInvalidState extends LoginState {
  const LoginCredentialsInvalidState(this.emailValid, this.passwordValid);

  final bool emailValid;
  final bool passwordValid;
  @override
  List<Object> get props => [emailValid, passwordValid];
}
