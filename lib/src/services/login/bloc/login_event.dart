import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent(
    this.email,
    this.password,
  );

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class LoginWithEmailPassword extends LoginEvent {
  const LoginWithEmailPassword(String email, String password)
      : super(email, password);
}

class LoginCredentialsChanged extends LoginEvent {
  const LoginCredentialsChanged(String email, String password)
      : super(email, password);
}
