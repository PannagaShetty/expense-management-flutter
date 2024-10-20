import 'package:fpdart/fpdart.dart';
import 'package:myapp/core/error/failure.dart';
import 'package:myapp/core/usecase/usecase.dart';
import 'package:myapp/core/common/entities/user.dart';
import 'package:myapp/features/auth/domain/repository/auth_repository.dart';

class UserSignInUsecase implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignInUsecase({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) {
    return authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
