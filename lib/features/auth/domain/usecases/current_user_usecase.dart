import 'package:fpdart/fpdart.dart';
import 'package:myapp/core/error/failure.dart';
import 'package:myapp/core/usecase/usecase.dart';
import 'package:myapp/core/common/entities/user.dart';
import 'package:myapp/features/auth/domain/repository/auth_repository.dart';

class CurrentUserUsecase implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUserUsecase({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.currentUser();
  }
}

class NoParams {}
