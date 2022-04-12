import 'package:biblio/src/services/common/validators.dart';
import 'package:bloc/bloc.dart';

import '../../auth/repo/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(const LoginInitState()) {
    on<LoginCredentialsChanged>(_loginCredentialsChanged);
    on<LoginWithEmailPassword>(_loginWithEmailPassword);
  }

  final AuthRepository _authRepository;

  Future<void> _loginCredentialsChanged(
      LoginCredentialsChanged event, Emitter<LoginState> emit) async {
    final emailValid = Validate.email(event.email);
    final passwordValid = Validate.password(event.password);
    if (emailValid && passwordValid) {
      emit(const LoginInitState());
    } else {
      emit(LoginCredentialsInvalidState(emailValid, passwordValid));
    }
  }

  Future<void> _loginWithEmailPassword(
    LoginWithEmailPassword event,
    Emitter<LoginState> emit,
  ) async {
    final messenger = await _authRepository.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    if (messenger.error) {
      emit(LoginFailedState(messenger.message));
    } else {
      emit(const LoginSuccessState());
    }
  }
}
