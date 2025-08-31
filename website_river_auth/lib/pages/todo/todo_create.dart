import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:website_river_auth/pages/todo/todo_provider.dart';

class TodoCreate extends StatefulComponent {
  @override
  State<StatefulComponent> createState() {
    return TodoState();
  }
}

class TodoState extends State<TodoCreate> {
  String _todoText = '';

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield h2([
      text('Todo'),
    ]);

    yield form(method: FormMethod.post, [
      label(htmlFor: 'text', [
        text('Text:'),
      ]),
      br(),
      input(
        id: 'text',
        name: 'text',
        type: InputType.text,
        onChange: (value) {
          // notifier.updateUserName(value);
          setState(
            () {
              _todoText = value;
            },
          );
        },
      ),
    ]);

    yield button(onClick: () async {
      if (_todoText.isNotEmpty) {
        final notifier = context.read(todoNotifierProvider.notifier);

        final result = await notifier.createTodo(_todoText);
        if (result) {
          context.push('/todos');
        }
      }
    }, [
      text('Create'),
    ]);
  }
}
