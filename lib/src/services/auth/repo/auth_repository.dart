import 'dart:developer';

import '../../../models/messenger.dart';
import '../../../models/user.dart';
import '../services/auth_service.dart';

class AuthRepository {
  const AuthRepository(AuthService authService) : _authService = authService;
  final AuthService _authService;

  Future<Messenger> signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
      return const Messenger.success();
    } catch (e) {
      log(e.toString());
      return Messenger.failure(message: e.toString());
    }
  }

  Future<Messenger> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Messenger.success();
    } catch (e) {
      log(e.toString());
      return Messenger.failure(message: e.toString());
    }
  }

  Future<Messenger> forgotPassword(
    String email,
  ) async {
    try {
      await _authService.forgotPassword(email: email);
      return const Messenger.success();
    } catch (e) {
      log(e.toString());
      return Messenger.failure(message: e.toString());
    }
  }

  Future<Messenger> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Messenger.success();
    } catch (e) {
      log(e.toString());
      return Messenger.failure(message: e.toString());
    }
  }

  Future<Messenger> signOut() async {
    try {
      await _authService.signOut();
      return const Messenger.success();
    } catch (e) {
      log(e.toString());
      return Messenger.failure(message: e.toString());
    }
  }

  Future<bool> isSignedIn() async {
    try {
      return _authService.isSignedIn;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  UserModel? get user {
    try {
      return _authService.currentUser;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
