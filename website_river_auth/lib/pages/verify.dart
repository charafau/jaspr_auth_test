import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:website_river_auth/providers/verify_notifier.dart';

class Verify extends StatefulComponent {
  @override
  State<StatefulComponent> createState() {
    return VerifyState();
  }
}

class VerifyState extends State<Verify> {
  late VerifyNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = context.read(verifyNotifierProvider.notifier);
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final state = context.watch(verifyNotifierProvider);

    yield h2([
      text('Verify'),
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
          notifier.updateEmail(value);
        },
      ),
      if (state.hasEmailError)
        span(classes: 'error', [
          text('Email must not be null'),
        ]),
      br(),
      br(),
      label(htmlFor: 'verify', [
        text('Verify Code:'),
      ]),
      br(),
      input(
        id: 'verify',
        name: 'verify',
        type: InputType.text,
        onChange: (value) {
          notifier.updateVerifyCode(value);
        },
      ),
      if (state.hasVerifyError)
        span(classes: 'error', [
          text('Verify code must not be null'),
        ]),
    ]);

    yield button(onClick: () async {
      final success = await notifier.verify();

      if (success) {
        context.push('/');
      }
    }, [
      text('Verify'),
    ]);
  }
}
