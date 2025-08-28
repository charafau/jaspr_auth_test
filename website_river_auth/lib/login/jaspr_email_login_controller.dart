import 'package:jaspr/jaspr.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart'
    hide VoidCallback;
import 'package:website_river_auth/login/jaspr_serverpod_session_manager.dart';
import 'package:universal_web/web.dart' as web;

class JasprEmailLoginController {
  Caller caller;

  /// Called if sign in is successful.
  final VoidCallback? onSignedIn;

  JasprEmailLoginController({
    required this.caller,
    this.onSignedIn,
  });

  Future<bool> isLoggedIn() async {
    var sessionManager = await JasprServerpodSessionManager.instance;

    return sessionManager.isSignedIn;
  }

  Future<UserInfo?> signIn(
      {required String email,
      required String password,
      bool rememberMe = false}) async {
    try {
      var serverResponse = await caller.email.authenticate(email, password);
      if (!serverResponse.success ||
          serverResponse.userInfo == null ||
          serverResponse.keyId == null ||
          serverResponse.key == null) {
        if (kDebugMode) {
          print(
            'serverpod_auth_email: Failed to authenticate with '
            'Serverpod backend: '
            '${serverResponse.failReason ?? 'reason unknown'}'
            '. Aborting.',
          );
        }
        return null;
      }

      // Authentication was successful, store the key.
      var sessionManager = await JasprServerpodSessionManager.instance;
      sessionManager.registerSignedInUser(serverResponse.userInfo!,
          serverResponse.keyId!, serverResponse.key!, !rememberMe);

      return serverResponse.userInfo;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e');
        print('$stackTrace');
      }
      return null;
    }
  }

  Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    return await caller.email.createAccountRequest(username, email, password);
  }

  Future<bool> verify({
    required String email,
    required String verificationCode,
  }) async {
    final userInfo = await caller.email.createAccount(email, verificationCode);

    return userInfo != null;
  }

  Future<bool> signOut() async {
    var sessionManager = await JasprServerpodSessionManager.instance;
    return await sessionManager.signOutDevice();
  }
}
