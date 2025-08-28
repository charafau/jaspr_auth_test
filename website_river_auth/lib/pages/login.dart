import 'package:jaspr/jaspr.dart';
import 'package:jaspr_auth_test_client/jaspr_auth_test_client.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:universal_web/web.dart' hide Client;
import 'package:website_river_auth/login/jaspr_email_login_controller.dart';
import 'package:website_river_auth/providers/login_notifier.dart';

class Login extends StatefulComponent {
  // final Client client;

  // Login({super.key, required this.client});

  @override
  State createState() => LoginState();
}

class LoginState extends State<Login> {
  // late JasprEmailLoginController loginController;

  String _email = '';
  String _password = '';
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // loginController =
    //     JasprEmailLoginController(caller: component.client.modules.auth);
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield h2([
      text('Login'),
    ]);

    yield form(method: FormMethod.post, [
      label(htmlFor: 'email', [
        text('Email:'),
      ]),
      br(),
      input(
        id: 'email',
        name: 'email',
        type: InputType.email,
        onChange: (value) {
          setState(() {
            _email = value;
          });
        },
      ),
      br(),
      br(),
      label(htmlFor: 'password', [
        text('Password:'),
      ]),
      br(),
      input(
        id: 'password',
        name: 'password',
        type: InputType.password,
        onChange: (value) {
          setState(() {
            _password = value;
          });
        },
      ),
      br(),
      br(),
      label(htmlFor: 'rememberme', [
        text('Remember Me:'),
      ]),
      input(
        id: 'rememberme',
        type: InputType.checkbox,
        onChange: (value) {
          setState(() {
            _rememberMe = value;
          });
        },
      ),
      br(),
      br(),
    ]);

    yield button(onClick: () async {
      final notifier = context.read(loginNotifierProvider.notifier);
      final success = await notifier.signIn(
          email: _email, password: _password, rememberMe: _rememberMe);
      if (success) {
        context.push('/');
      }
    }, [
      text('Login'),
    ]);
  }
}
