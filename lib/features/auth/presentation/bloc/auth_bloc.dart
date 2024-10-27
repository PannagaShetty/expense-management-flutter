import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:myapp/core/common/entities/user.dart';
import 'package:myapp/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:myapp/features/auth/domain/usecases/user_sign_in_usecase.dart';
import 'package:myapp/features/auth/domain/usecases/user_sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUsecase _userSignUp;
  final UserSignInUsecase _userSignIn;
  final CurrentUserUsecase _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUpUsecase userSignUpUsecase,
    required UserSignInUsecase userSignInUsecase,
    required CurrentUserUsecase currentUserUsecase,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUpUsecase,
        _userSignIn = userSignInUsecase,
        _currentUser = currentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserSignedIn>(_isUserLoggedIn);
  }
  void _isUserLoggedIn(AuthIsUserSignedIn event, Emitter<AuthState> emit) async {
    final result = await _currentUser(NoParams());

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final result = await _userSignUp(UserSignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final result = await _userSignIn(UserSignInParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
