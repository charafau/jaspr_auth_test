import 'dart:async';

import 'package:jaspr_auth_test_client/jaspr_auth_test_client.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:website_river_auth/pages/todo/todo_state.dart';
import 'package:website_river_auth/providers/client_provider.dart';

final todoNotifierProvider =
    AsyncNotifierProvider<TodoNotifier, TodoState>(() => TodoNotifier());

class TodoNotifier extends AsyncNotifier<TodoState> {
  late Client _client;

  @override
  Future<TodoState> build() async {
    _client = ref.read(clientProvider);

    return _loadData();
  }

  Future<TodoState> _loadData() async {
    final todos = await _client.todo.getTodos();

    return TodoState(todos: todos);
  }

  Future<bool> createTodo(String text) async {
    try {
      await _client.todo.createTodo(text);

      state = AsyncData(await _loadData());

      return true;

      // return result;
    } catch (e) {
      print('got error ${e.toString()}');

      return false;
    }
  }
}
