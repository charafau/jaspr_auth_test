/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Todo implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Todo._({
    this.id,
    required this.text,
    bool? done,
    this.userId,
  }) : done = done ?? true;

  factory Todo({
    int? id,
    required String text,
    bool? done,
    int? userId,
  }) = _TodoImpl;

  factory Todo.fromJson(Map<String, dynamic> jsonSerialization) {
    return Todo(
      id: jsonSerialization['id'] as int?,
      text: jsonSerialization['text'] as String,
      done: jsonSerialization['done'] as bool,
      userId: jsonSerialization['userId'] as int?,
    );
  }

  static final t = TodoTable();

  static const db = TodoRepository._();

  @override
  int? id;

  String text;

  bool done;

  /// The user id of the user who created the recipe
  int? userId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Todo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Todo copyWith({
    int? id,
    String? text,
    bool? done,
    int? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'done': done,
      if (userId != null) 'userId': userId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'done': done,
    };
  }

  static TodoInclude include() {
    return TodoInclude._();
  }

  static TodoIncludeList includeList({
    _i1.WhereExpressionBuilder<TodoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TodoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TodoTable>? orderByList,
    TodoInclude? include,
  }) {
    return TodoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Todo.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Todo.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TodoImpl extends Todo {
  _TodoImpl({
    int? id,
    required String text,
    bool? done,
    int? userId,
  }) : super._(
          id: id,
          text: text,
          done: done,
          userId: userId,
        );

  /// Returns a shallow copy of this [Todo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Todo copyWith({
    Object? id = _Undefined,
    String? text,
    bool? done,
    Object? userId = _Undefined,
  }) {
    return Todo(
      id: id is int? ? id : this.id,
      text: text ?? this.text,
      done: done ?? this.done,
      userId: userId is int? ? userId : this.userId,
    );
  }
}

class TodoTable extends _i1.Table<int?> {
  TodoTable({super.tableRelation}) : super(tableName: 'todo') {
    text = _i1.ColumnString(
      'text',
      this,
    );
    done = _i1.ColumnBool(
      'done',
      this,
      hasDefault: true,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
  }

  late final _i1.ColumnString text;

  late final _i1.ColumnBool done;

  /// The user id of the user who created the recipe
  late final _i1.ColumnInt userId;

  @override
  List<_i1.Column> get columns => [
        id,
        text,
        done,
        userId,
      ];
}

class TodoInclude extends _i1.IncludeObject {
  TodoInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Todo.t;
}

class TodoIncludeList extends _i1.IncludeList {
  TodoIncludeList._({
    _i1.WhereExpressionBuilder<TodoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Todo.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Todo.t;
}

class TodoRepository {
  const TodoRepository._();

  /// Returns a list of [Todo]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Todo>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TodoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TodoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TodoTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Todo>(
      where: where?.call(Todo.t),
      orderBy: orderBy?.call(Todo.t),
      orderByList: orderByList?.call(Todo.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Todo] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Todo?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TodoTable>? where,
    int? offset,
    _i1.OrderByBuilder<TodoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TodoTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Todo>(
      where: where?.call(Todo.t),
      orderBy: orderBy?.call(Todo.t),
      orderByList: orderByList?.call(Todo.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Todo] by its [id] or null if no such row exists.
  Future<Todo?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Todo>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Todo]s in the list and returns the inserted rows.
  ///
  /// The returned [Todo]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Todo>> insert(
    _i1.Session session,
    List<Todo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Todo>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Todo] and returns the inserted row.
  ///
  /// The returned [Todo] will have its `id` field set.
  Future<Todo> insertRow(
    _i1.Session session,
    Todo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Todo>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Todo]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Todo>> update(
    _i1.Session session,
    List<Todo> rows, {
    _i1.ColumnSelections<TodoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Todo>(
      rows,
      columns: columns?.call(Todo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Todo]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Todo> updateRow(
    _i1.Session session,
    Todo row, {
    _i1.ColumnSelections<TodoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Todo>(
      row,
      columns: columns?.call(Todo.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Todo]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Todo>> delete(
    _i1.Session session,
    List<Todo> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Todo>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Todo].
  Future<Todo> deleteRow(
    _i1.Session session,
    Todo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Todo>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Todo>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TodoTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Todo>(
      where: where(Todo.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TodoTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Todo>(
      where: where?.call(Todo.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
