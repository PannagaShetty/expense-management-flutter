part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthIsUserSignedIn extends AuthEvent {}
