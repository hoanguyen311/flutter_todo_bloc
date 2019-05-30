import 'package:equatable/equatable.dart';
import 'package:bloc_todo/models/todo.dart';


class TodosEvent extends Equatable {
  TodosEvent([props = const []]): super(props);

  @override
  String toString() => 'TodosEvent';
}

class LoadTodos extends TodosEvent {
  @override
  String toString() => 'LoadTodos';
}

class ClearCompleted extends TodosEvent {
  @override
  String toString() => 'ClearCompleted';
}

class ToggleAll extends TodosEvent {
  @override
  String toString() => 'ToggleAll';
}


class AddTodo extends TodosEvent {
  @override
  String toString() => 'AddTodo';

  AddTodo(this.todo): super([todo]);

  final Todo todo;
}

class DeleteTodo extends TodosEvent {
  @override
  String toString() => 'DeleteTodo';

  DeleteTodo(this.todo): super([todo]);

  final Todo todo;
}


class UpdateTodo extends TodosEvent {
  @override
  String toString() => 'UpdateTodo(${updatedTodo.id}, task: "${updatedTodo.task}, completed: ${updatedTodo.complete}")';

  UpdateTodo(this.updatedTodo): super([updatedTodo]);

  final Todo updatedTodo;
}