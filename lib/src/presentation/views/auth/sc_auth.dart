import 'package:biblio/src/services/auth/bloc/auth_bloc.dart';
import 'package:biblio/src/services/auth/repo/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await context.read<AuthRepository>().signInWithEmailAndPassword(
                  email: 'user@gmail.com',
                  password: 'pass123',
                );
            Navigator.of(context).pop();
            context.read<AuthBloc>().add(AuthEventLogin());
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
