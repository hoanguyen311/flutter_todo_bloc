import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

@immutable
class Todo extends Equatable {
  final String task;
  final String id;
  final String note;
  final bool complete;

  Todo(this.task, { String id, String note, bool complete }):
      this.id = id ?? Uuid().generateV4(),
      this.note = note ?? '',
      this.complete = complete ?? false,
      super([id, task, note, complete]);

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      id: entity.id ?? Uuid().generateV4(),
      note: entity.note,
      complete: entity.complete ?? false
    );
  }

  Todo copyWith({ bool complete, String task, String note, String id }) {
    return Todo(
      task ?? this.task,
      id: id ?? this.id,
      note: note ?? this.note,
      complete: complete ?? this.complete,
    );
  }

  @override
  String toString() {
    return 'Todo(${this.task}, id: ${this.id}, note: ${this.note}, complete: ${this.complete})';
  }
}