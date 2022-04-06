import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repo/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(const AuthUninitialized()) {
    on<AuthEventStart>(_onAppStart);
    on<AuthEventLogin>(_onLogin);
    on<AuthEventLogout>(_onLogout);
  }

  final AuthRepository _authRepository;

  Future<void> _onAppStart(
    AuthEventStart event,
    Emitter<AuthState> emit,
  ) async {
    final isSignedIn = await _authRepository.isSignedIn();
    if (isSignedIn) {
      emit(Authenticated(_authRepository.user!.id));
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> _onLogin(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(Authenticated(_authRepository.user!.id));
  }

  void _onLogout(AuthEventLogout event, Emitter<AuthState> emit) {
    emit(const Unauthenticated());
    _authRepository.signOut();
  }
}
