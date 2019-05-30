import 'package:equatable/equatable.dart';
import 'package:bloc_todo/models/todo.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosState extends Equatable {
  TodosState([List props = const []]): super(props);

  @override
  String toString() => 'TodosState';
}

class TodosLoading extends TodosState {
  @override
  String toString() => 'TodosLoading';
}

class TodosLoaded extends TodosState {
  @override
  String toString() => 'TodosLoaded(todos: ${todos})';

  TodosLoaded([this.todos = const []]): super([todos]);

  final List<Todo> todos;

}

class TodosUnloaded extends TodosState {
  @override
  String toString() => 'TodosUnloaded';
}