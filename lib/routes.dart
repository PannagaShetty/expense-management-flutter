import 'package:go_router/go_router.dart';
import 'package:myapp/core/helpers/listenables_from_stream.dart';
import 'package:myapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myapp/features/auth/presentation/sign_in_page.dart';
import 'package:myapp/features/auth/presentation/sign_up_page.dart';
import 'package:myapp/features/auth/presentation/splash_page.dart';
import 'package:myapp/home.dart';
import 'package:myapp/init_dependencies.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashPage.routePath,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: SplashPage.routePath,
      name: SplashPage.routeName,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: SignInPage.routePath,
      name: SignInPage.routeName,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: SignUpPage.routePath,
      name: SignUpPage.routeName,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: HomePage.routePath,
      name: HomePage.routeName,
      builder: (context, state) => const HomePage(),
    ),
  ],
  refreshListenable: StreamToListenable([serviceLocator<AuthBloc>().stream]),
  redirect: (context, state) {
    final isAuthenticated = serviceLocator<AuthBloc>().state is AuthSuccess;
    final isUnAuthenticated = serviceLocator<AuthBloc>().state is AuthFailure || serviceLocator<AuthBloc>().state is AuthLogout;

    if (isUnAuthenticated && !state.matchedLocation.contains(SignUpPage.routePath)) {
      return SignInPage.routePath;
    } else if (isAuthenticated) {
      return HomePage.routePath;
    }
    return null;
  },
);
