part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventStart extends AuthEvent {}

class AuthEventLogin extends AuthEvent {}

class AuthEventLogout extends AuthEvent {}
