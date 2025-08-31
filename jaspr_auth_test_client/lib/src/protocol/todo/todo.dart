/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Todo implements _i1.SerializableModel {
  Todo._({
    this.id,
    required this.text,
    bool? done,
  }) : done = done ?? true;

  factory Todo({
    int? id,
    required String text,
    bool? done,
  }) = _TodoImpl;

  factory Todo.fromJson(Map<String, dynamic> jsonSerialization) {
    return Todo(
      id: jsonSerialization['id'] as int?,
      text: jsonSerialization['text'] as String,
      done: jsonSerialization['done'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String text;

  bool done;

  /// Returns a shallow copy of this [Todo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Todo copyWith({
    int? id,
    String? text,
    bool? done,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'done': done,
    };
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
  }) : super._(
          id: id,
          text: text,
          done: done,
        );

  /// Returns a shallow copy of this [Todo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Todo copyWith({
    Object? id = _Undefined,
    String? text,
    bool? done,
  }) {
    return Todo(
      id: id is int? ? id : this.id,
      text: text ?? this.text,
      done: done ?? this.done,
    );
  }
}
