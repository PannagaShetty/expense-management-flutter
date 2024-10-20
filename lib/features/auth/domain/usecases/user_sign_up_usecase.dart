import 'package:fpdart/fpdart.dart';
import 'package:myapp/core/error/failure.dart';
import 'package:myapp/core/usecase/usecase.dart';
import 'package:myapp/core/common/entities/user.dart';
import 'package:myapp/features/auth/domain/repository/auth_repository.dart';

class UserSignUpUsecase implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUpUsecase({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({required this.name, required this.email, required this.password});
}
