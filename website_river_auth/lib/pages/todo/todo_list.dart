import 'package:jaspr/jaspr.dart';
import 'package:jaspr_auth_test_client/jaspr_auth_test_client.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:website_river_auth/pages/todo/todo_provider.dart';

//class TodoList extends StatelessComponent {
//  @override
//  Iterable<Component> build(BuildContext context) sync* {
//    yield div([]);
//  }
//}

class TodoList extends StatefulComponent {
  @override
  State<StatefulComponent> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  List<Todo> todos = [];

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final data = context.watch(todoNotifierProvider);

    yield div([
      a([text('Create todo')], href: '/todos_create')
    ]);

    if (data.hasValue) {
      // data.value!.todos
      for (var todo in data.value!.todos) {
        yield div([text(todo.text)]);
      }
    }
  }
}

//class TodoList extends AsyncStatelessComponent {
//  @override
//  Future<Component> build(BuildContext context) async {
//    final data = await context.watch(todoNotifierProvider.future);
//
//    return Todos(todos: data.todos);
//  }
//}
//
//class Todos extends StatelessComponent {
//  final List<Todo> todos;
//
//  Todos({super.key, required this.todos});
//
//  @override
//  Iterable<Component> build(BuildContext context) sync* {
//    todos.forEach(
//      (element) sync* {
//        yield div([text(element.text)]);
//      },
//    );
//  }
//}

  // @override
  // Stream<Iterable<Component>> build(
  //   BuildContext context,
  // ) async* {
  //   final todos = context.watch(todoNotifierProvider);

  //   yield* div([
  //     a([text('Create todo')], href: '/todo_create')
  //   ]);

  //   if (todos.hasValue) {
  //     todos.value!.todos.forEach(
  //       (element) sync* {
  //         yield div([text(element.text)]);
  //       },
  //     );
  //   }

  // yield* todos.when(
  //   data: (data) sync* {
  //     data.todos.forEach(
  //       (element) sync* {
  //         yield div([text(element.text)]);
  //       },
  //     );
  //   },
  //   error: (error, stackTrace) sync* {
  //     yield div([text('Got error')]);
  //   },
  //   loading: () sync* {
  //     yield div([text('Loading...')]);
  //   },
  // );
  // }
