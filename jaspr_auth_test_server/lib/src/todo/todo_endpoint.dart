import 'package:jaspr_auth_test_server/src/generated/todo/todo.dart';
import 'package:serverpod/serverpod.dart';

class TodoEndpoint extends Endpoint {
  Future<List<Todo>> getTodos(Session session) async {
    final userId = (await session.authenticated)?.userId;

    if (userId == null) {
      return [];
    }

    return Todo.db.find(session, where: (t) => t.userId.equals(userId));
  }

  Future<Todo> createTodo(Session session, String text) async {
    final userId = (await session.authenticated)?.userId;

    if (userId == null) {
      throw NotAuthorizedException(
          ResultAuthenticationFailed.insufficientAccess(
              'You must be logged in to create todo'));
    }

    final todo = Todo(text: text, userId: userId);

    return await Todo.db.insertRow(session, todo);
  }
}
