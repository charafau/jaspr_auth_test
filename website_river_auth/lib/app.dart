import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:website_river_auth/pages/login.dart';
import 'package:website_river_auth/pages/register.dart';
import 'package:website_river_auth/pages/todo/todo_create.dart';
import 'package:website_river_auth/pages/todo/todo_list.dart';
import 'package:website_river_auth/pages/verify.dart';

import 'components/header.dart';
import 'pages/home.dart';

// The main component of your application.
class App extends StatelessComponent {
  const App({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // This method is rerun every time the component is rebuilt.
    //
    // Each build method can return multiple child components as an [Iterable]. The recommended approach
    // is using the [sync* / yield] syntax for a streamlined control flow, but its also possible to simply
    // create and return a [List] here.

    // Renders a <div class="main"> html element with children.
    yield div(classes: 'main', [
      Router(routes: [
        ShellRoute(
          builder: (context, state, child) => Fragment(children: [
            const Header(),
            child,
          ]),
          routes: [
            Route(
                path: '/',
                title: 'Home',
                builder: (context, state) => const Home()),
            Route(
              path: '/todos',
              title: 'Todos',
              builder: (context, state) => TodoList(),
            ),
            Route(
              path: '/todos_create',
              title: 'Todo Create',
              builder: (context, state) => TodoCreate(),
            ),
            Route(
                path: '/login',
                title: 'Login',
                builder: (context, state) => Login()),
            Route(
                path: '/register',
                title: 'Register',
                builder: (context, state) => Register()),
            Route(
                path: '/verify',
                title: 'Verify',
                builder: (context, state) => Verify()),
          ],
        ),
      ]),
    ]);
  }
}
