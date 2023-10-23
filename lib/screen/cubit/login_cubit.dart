import 'package:assesmant_task/core/model/user_model.dart';
import 'package:assesmant_task/core/repositry/auth_repository.dart';
import 'package:assesmant_task/core/utils/utils.dart';
import 'package:assesmant_task/screen/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(AuthState.initial());

  AuthRepository auth = AuthRepository();

  Future<void> signIn({required UserModel user}) async {
    try {
      emit(AuthState.loading());
      auth.login(user: user).then((value) => Get.to(() => PokemonList()));
      emit(AuthState.success());
      successSnackBar('Login Successful');
    } catch (e) {
      emit(AuthState.error(e.toString()));
      errorSnackBar(e.toString());
      // Get.log(e.toString());
    }
  }

  Future<void> signUp({required UserModel user}) async {
    try {
      emit(AuthState.loading());
      auth.register(user: user).then((value) => Get.to(() => PokemonList()));
      emit(AuthState.success());
      successSnackBar('Account Created Successful');
    } catch (e) {
      emit(AuthState.error(e.toString()));
      errorSnackBar(e.toString());
      // Get.log(e.toString());
    }
  }
}

class AuthState {
  final bool isLoading;
  final bool isSuccessful;
  final String error;

  const AuthState({
    required this.isLoading,
    required this.isSuccessful,
    required this.error,
  });

  factory AuthState.initial() => const AuthState(
        isLoading: false,
        isSuccessful: false,
        error: '',
      );

  factory AuthState.loading() => const AuthState(
        isLoading: true,
        isSuccessful: false,
        error: '',
      );

  factory AuthState.success() => const AuthState(
        isLoading: false,
        isSuccessful: true,
        error: '',
      );

  factory AuthState.error(String error) => AuthState(
        isLoading: false,
        isSuccessful: false,
        error: error,
      );
}
