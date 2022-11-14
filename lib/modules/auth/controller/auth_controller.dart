import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/common/utils.dart';
import 'package:music_app/modules/auth/repository/auth_repository.dart';
import 'package:music_app/modules/home/screens/home_screen.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  var authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(false);

  void signInWithGoogle(BuildContext context) async {
    state = true;
    var res = await _authRepository.signInWithGoogle();

    res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false));

    state = false;
  }
}

class TokenProiver extends StateNotifier<String> {
  TokenProiver() : super('');

  void updateToken(String value) {
    state = value;
  }
}
