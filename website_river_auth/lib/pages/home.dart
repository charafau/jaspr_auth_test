import 'package:jaspr/jaspr.dart';

class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    return section([
      h1([text('Welcome')]),
      p([text('You successfully create a new Jaspr site.')]),
    ]);
  }
}
