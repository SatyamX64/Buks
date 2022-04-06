import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/presentation/views/collection/collection_view.dart';
import '/src/presentation/views/auth/sc_auth.dart';
import '/src/presentation/views/onboarding/onboarding_view.dart';
import '/src/presentation/views/splash/splash_view.dart';
import '/src/services/auth/services/auth_service.dart';
import '/src/services/collections/collection_controller.dart';
import '/src/services/collections/collection_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'services/auth/bloc/auth_bloc.dart';
import 'services/auth/repo/auth_repository.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository(AuthService());
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(authRepository)..add(AuthEventStart()),
          ),
        ],
        child: MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),

          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthUninitialized) {
                return const SplashView();
              } else if (state is Unauthenticated) {
                return const OnBoardingView();
              } else if (state is Authenticated) {
                return CollectionView(
                  CollectionController(
                    CollectionService(state.uid),
                  ),
                );
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text('Unhandled State'),
                  ),
                );
              }
            },
          ),

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case AuthView.routeName:
                    return const AuthView();
                  case CollectionView.routeName:
                    final id = routeSettings.arguments as String;
                    return CollectionView(
                      CollectionController(
                        CollectionService(id),
                      ),
                    );
                  default:
                    return const Scaffold(
                      body: Center(
                        child: Text('No Route defined'),
                      ),
                    );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
