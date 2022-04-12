import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/repo/auth_repository.dart';
import '../../common/validators.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(const RegisterInitState()) {
    on<RegisterWithEmailPassword>(_registerWithEmailPassword);
    on<RegisterCredentialsChanged>(_credentialsChanged);
  }

  final AuthRepository _authRepository;

  Future<void> _registerWithEmailPassword(
    RegisterWithEmailPassword event,
    Emitter<RegisterState> emit,
  ) async {
    final messenger = await _authRepository.createUserWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    if (messenger.error) {
      emit(RegisterFailedState(messenger.message));
    } else {
      emit(const RegisterSuccessState());
    }
  }

  Future<void> _credentialsChanged(
      RegisterCredentialsChanged event, Emitter<RegisterState> emit) async {
    final emailValid = Validate.email(event.email);
    final passwordValid = Validate.password(event.password);
    if (emailValid && passwordValid) {
      emit(const RegisterInitState());
    } else {
      emit(RegisterCredentialsInvalidState(emailValid, passwordValid));
    }
  }
}
