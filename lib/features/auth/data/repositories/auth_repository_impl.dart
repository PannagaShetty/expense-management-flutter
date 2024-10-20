import 'package:fpdart/fpdart.dart';
import 'package:myapp/core/error/exception.dart';
import 'package:myapp/core/error/failure.dart';
import 'package:myapp/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:myapp/core/common/entities/user.dart';
import 'package:myapp/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({required String email, required String password}) async {
    return _getUser(() async => await authRemoteDataSource.signInWithEmailAndPassword(
          email: email,
          password: password,
        ));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({required String name, required String email, required String password}) async {
    return _getUser(() async => await authRemoteDataSource.signUpWithEmailAndPassword(
          name: name,
          email: email,
          password: password,
        ));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() getUser) async {
    try {
      final user = await getUser();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        throw ServerException('User is null');
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
