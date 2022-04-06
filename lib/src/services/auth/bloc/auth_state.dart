part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthUninitialized extends AuthState {
  const AuthUninitialized();
}

class Authenticated extends AuthState {
  final String uid;
  const Authenticated(this.uid);

  @override
  List<Object> get props => [uid];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}
