import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitState extends RegisterState {
  const RegisterInitState();
}

class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState();
}

class RegisterSuccessState extends RegisterState {
  const RegisterSuccessState();
}

class RegisterFailedState extends RegisterState {
  const RegisterFailedState(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class RegisterCredentialsInvalidState extends RegisterState {
  const RegisterCredentialsInvalidState(this.emailValid, this.passwordValid);

  final bool emailValid;
  final bool passwordValid;
  @override
  List<Object> get props => [emailValid, passwordValid];
}
