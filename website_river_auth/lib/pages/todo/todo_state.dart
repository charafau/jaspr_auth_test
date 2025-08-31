// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:jaspr_auth_test_client/jaspr_auth_test_client.dart';

class TodoState {
  final List<Todo> todos;
  TodoState({
    required this.todos,
  });

  TodoState copyWith({
    List<Todo>? todos,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
    );
  }

  @override
  String toString() => 'TodoState(todos: $todos)';

  @override
  int get hashCode => todos.hashCode;
}
