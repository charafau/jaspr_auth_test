import 'dart:async';

import 'package:jaspr_auth_test_client/jaspr_auth_test_client.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:serverpod_auth_client/module.dart';
import 'package:website_river_auth/login/jaspr_email_login_controller.dart';
import 'package:website_river_auth/providers/client_provider.dart';
import 'package:website_river_auth/providers/states/verify_state.dart';

final verifyNotifierProvider =
    NotifierProvider<VerifyNotifier, VerifyNotifierState>(
  () => VerifyNotifier(),
);

class VerifyNotifier extends Notifier<VerifyNotifierState> {
  late JasprEmailLoginController _emailLoginController;
  late Client _client;

  @override
  VerifyNotifierState build() {
    _client = ref.read(clientProvider);
    _emailLoginController =
        JasprEmailLoginController(caller: _client.modules.auth);

    return VerifyNotifierState();
  }

  Future<bool> verify() async {
    if (state.verify.isNotEmpty && state.email.isNotEmpty) {
      return await _emailLoginController.verify(
          email: state.email, verificationCode: state.verify);
    } else {
      state = VerifyNotifierState(
        hasVerifyError: state.verify.isEmpty,
        hasEmailError: state.email.isEmpty,
      );
      return false;
    }
  }

  void updateVerifyCode(value) {
    state = state.copyWith(verify: value);
  }

  void updateEmail(value) {
    state = state.copyWith(email: value);
  }
}

class RegisterNotifierArgs {
  final Caller caller;

  RegisterNotifierArgs({required this.caller});
}
