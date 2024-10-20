import 'package:get_it/get_it.dart';
import 'package:myapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:myapp/core/secrets/app_secrets.dart';
import 'package:myapp/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:myapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:myapp/features/auth/domain/repository/auth_repository.dart';
import 'package:myapp/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:myapp/features/auth/domain/usecases/user_sign_in_usecase.dart';
import 'package:myapp/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:myapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
  //Core
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());
  _initAuth();
}

void _initAuth() {
  serviceLocator
    //Data sources
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()))

    //Repositories
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(authRemoteDataSource: serviceLocator()))

    //UseCases
    ..registerFactory(() => UserSignUpUsecase(authRepository: serviceLocator()))
    ..registerFactory(() => UserSignInUsecase(authRepository: serviceLocator()))
    ..registerFactory(() => CurrentUserUsecase(authRepository: serviceLocator()))

    //Blocs
    ..registerLazySingleton(() => AuthBloc(
          userSignUpUsecase: serviceLocator(),
          userSignInUsecase: serviceLocator(),
          currentUserUsecase: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
}
