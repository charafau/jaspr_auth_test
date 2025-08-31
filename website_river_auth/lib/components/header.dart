import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:website_river_auth/providers/login_notifier.dart';
import 'package:website_river_auth/providers/states/login_state.dart';

class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    var activePath = RouteState.of(context).location;

    final AsyncValue<LoginNotifierState> loginState =
        context.watch(loginNotifierProvider);

    yield header([
      nav([
        for (var route in [
          (label: 'Home', path: '/'),
          (label: 'Todos', path: '/todos'),
          (label: 'Login', path: '/login'),
          (label: 'Register', path: '/register'),
          (label: 'Verify', path: '/verify'),
        ])
          div(classes: activePath == route.path ? 'active' : null, [
            Link(to: route.path, child: text(route.label)),
          ]),
        div(
            styles: Styles(
              color: Colors.white,
              fontSize: Unit.rem(1.2),
            ),
            [
              loginState.when(data: (LoginNotifierState data) {
                return div([
                  text('Is Logged In: ${data.isLoggedIn} '),
                  a(
                    [text('Logout')],
                    href: '#',
                    onClick: () async {
                      final notifier =
                          context.read(loginNotifierProvider.notifier);
                      final success = await notifier.signOut();
                      if (success) {
                        context.push('/');
                      }
                    },
                  )
                ]);
              }, error: (Object error, StackTrace stackTrace) {
                return text('Error');
              }, loading: () {
                return text('Loading');
              }),
            ]),
      ]),
    ]);
  }
}
