import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent(this.email, this.password);

  final String email;
  final String password;
  @override
  List<Object> get props => [email, password];
}

class RegisterWithEmailPassword extends RegisterEvent {
  const RegisterWithEmailPassword(String email, String password)
      : super(email, password);
}

class RegisterCredentialsChanged extends RegisterEvent {
  const RegisterCredentialsChanged(String email, String password)
      : super(email, password);
}
