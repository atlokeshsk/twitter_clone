import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/apis.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/models/models.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authAPI = ref.watch(authAPIProvider);
  final userAPI = ref.watch(userAPIProvider);
  return AuthController(authAPI: authAPI, userAPI: userAPI);
});

final currentUserProvider = FutureProvider<User?>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUserAccount();
});

class AuthController extends StateNotifier<bool> {
  AuthController({required IAuthAPI authAPI, required IUserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  final IAuthAPI _authAPI;
  final IUserAPI _userAPI;

  Future<User?> currentUserAccount() => _authAPI.currentUserAccount();

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final result = await _authAPI.signUp(email: email, password: password);
    state = false;
    result.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        final userModel =
            UserModel.newUser(name: getNameFromEmail(email), email: email);
        final userCreationResult = await _userAPI.saveUserData(userModel);
        userCreationResult.fold(
          (l) => showSnackBar(context, l.message),
          (r) {
            showSnackBar(context, 'Account Creation Succesfull Please login');
            Navigator.of(context).pushReplacement(LoginView.route());
          },
        );
      },
    );
  }

  void logIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final result = await _authAPI.logIn(email: email, password: password);
    state = false;
    result.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, 'LogIn Sucessfull');
        Navigator.pushReplacement(context, HomeView.route());
      },
    );
  }
}
