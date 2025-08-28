import 'dart:async';

import 'package:jaspr_auth_test_client/jaspr_auth_test_client.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:serverpod_auth_client/module.dart';
import 'package:website_river_auth/login/jaspr_email_login_controller.dart';
import 'package:website_river_auth/providers/client_provider.dart';
import 'package:website_river_auth/providers/states/register_state.dart';

final registerNotifierProvider =
    NotifierProvider<RegisterNotifier, RegisterNotifierState>(
  () => RegisterNotifier(),
);

class RegisterNotifier extends Notifier<RegisterNotifierState> {
  late JasprEmailLoginController _emailLoginController;
  late Client _client;

  @override
  RegisterNotifierState build() {
    _client = ref.read(clientProvider);
    _emailLoginController =
        JasprEmailLoginController(caller: _client.modules.auth);

    return RegisterNotifierState();
  }

  Future<bool> register() async {
    if (state.username.isNotEmpty &&
        state.email.isNotEmpty &&
        state.password.isNotEmpty &&
        state.password == state.passwordRepeat) {
      return await _emailLoginController.register(
        username: state.username,
        email: state.email,
        password: state.password,
      );
    } else {
      state = RegisterNotifierState(
          hasUsernameError: state.username.isEmpty,
          hasEmailError: state.email.isEmpty,
          hasPasswordError: state.password.isEmpty,
          hasPasswordRepeatError: state.password != state.passwordRepeat ||
              state.passwordRepeat.isEmpty);
      return false;
    }
  }

  void updateEmail(value) {
    state = state.copyWith(email: value);
  }

  void updateUserName(value) {
    state = state.copyWith(username: value);
  }

  void updatePassword(value) {
    state = state.copyWith(password: value);
  }

  void updatePasswordRepeat(value) {
    state = state.copyWith(passwordRepeat: value);
  }
}

class RegisterNotifierArgs {
  final Caller caller;

  RegisterNotifierArgs({required this.caller});
}
