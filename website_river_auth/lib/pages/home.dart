import 'package:jaspr/jaspr.dart';

class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section([
      h1([text('Welcome')]),
      p([text('You successfully create a new Jaspr site.')]),
    ]);
  }
}
