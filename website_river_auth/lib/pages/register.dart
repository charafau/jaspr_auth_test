import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:website_river_auth/providers/login_notifier.dart';
import 'package:website_river_auth/providers/register_notifier.dart';

class Register extends StatefulComponent {
  @override
  State<StatefulComponent> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  late RegisterNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = context.read(registerNotifierProvider.notifier);
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final state = context.watch(registerNotifierProvider);

    yield h2([
      text('Register'),
    ]);

    yield form(method: FormMethod.post, [
      label(htmlFor: 'userName', [
        text('User Name:'),
      ]),
      br(),
      input(
        id: 'userName',
        name: 'userName',
        type: InputType.text,
        onChange: (value) {
          notifier.updateUserName(value);
        },
      ),
      if (state.hasUsernameError)
        span(classes: 'error', [
          text('User Name must not be null'),
        ]),
      br(),
      br(),
      label(htmlFor: 'email', [
        text('Email:'),
      ]),
      br(),
      input(
        id: 'email',
        name: 'email',
        type: InputType.email,
        onChange: (value) {
          notifier.updateEmail(value);
        },
      ),
      if (state.hasEmailError)
        span(classes: 'error', [
          text('Email must not be null'),
        ]),
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
          notifier.updatePassword(value);
        },
      ),
      if (state.hasPasswordError)
        span(classes: 'error', [
          text('Password must not be null'),
        ]),
      br(),
      br(),
      label(htmlFor: 'passwordRepeat', [
        text('Repeat Password:'),
      ]),
      br(),
      input(
        id: 'passwordRepeat',
        name: 'passwordRepeat',
        type: InputType.password,
        onChange: (value) {
          notifier.updatePasswordRepeat(value);
        },
      ),
      if (state.hasPasswordRepeatError)
        span(classes: 'error', [
          text('Passwords must be equal'),
        ]),
      br(),
      br(),
    ]);

    yield button(onClick: () async {
      final success = await notifier.register();

      if (success) {
        context.push('/');
      }
    }, [
      text('Register'),
    ]);
  }
}
