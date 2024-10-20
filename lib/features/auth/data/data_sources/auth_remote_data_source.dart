import 'package:myapp/core/error/exception.dart';
import 'package:myapp/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getSupabaseResponse(() async => await supabaseClient.auth.signUp(password: password, email: email, data: {
          'full_name': name,
        }));
  }

  @override
  Future<UserModel> signInWithEmailAndPassword({required String email, required String password}) async {
    return _getSupabaseResponse(() async => await supabaseClient.auth.signInWithPassword(
          password: password,
          email: email,
        ));
  }

  Future<UserModel> _getSupabaseResponse(Future<AuthResponse> Function() getUser) async {
    try {
      final response = await getUser();
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModel.fromMap(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message, statusCode: e.statusCode, errorCode: e.code);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final user = await supabaseClient.from('profiles').select().eq('id', currentUserSession!.user.id).single();
        return UserModel.fromMap(user);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
