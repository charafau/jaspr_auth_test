import 'dart:async';

import 'package:jaspr_auth_test_client/jaspr_auth_test_client.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:serverpod_auth_client/module.dart';
import 'package:website_river_auth/login/jaspr_email_login_controller.dart';
import 'package:website_river_auth/providers/client_provider.dart';
import 'package:website_river_auth/providers/states/login_state.dart';

final loginNotifierProvider =
    AsyncNotifierProvider<LoginNotifier, LoginNotifierState>(
  () => LoginNotifier(),
);

class LoginNotifier extends AsyncNotifier<LoginNotifierState> {
  late JasprEmailLoginController _loginController;
  late Client _client;

  @override
  Future<LoginNotifierState> build() async {
    _client = ref.read(clientProvider);
    _loginController = JasprEmailLoginController(caller: _client.modules.auth);

    final isLoggedIn = await _loginController.isLoggedIn();

    return LoginNotifierState(isLoggedIn: isLoggedIn, userInfo: null);
  }

  Future<bool> signIn({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final userInfo = await _loginController.signIn(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    state = AsyncData(LoginNotifierState(
      isLoggedIn: userInfo != null,
      userInfo: userInfo,
    ));

    return userInfo != null;
  }

  Future<bool> signOut() async {
    final result = await _loginController.signOut();

    if (result) {
      state = AsyncData(LoginNotifierState(isLoggedIn: false, userInfo: null));
    }

    return result;
  }
}

class LoginNotifierArgs {
  final Caller caller;

  LoginNotifierArgs({required this.caller});
}
