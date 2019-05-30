import 'package:equatable/equatable.dart';
import '../../models/models.dart';

class FilteredTodosState extends Equatable {
  FilteredTodosState([props = const []]): super(props);


  @override
  String toString() => 'FilteredTodosState';
}

class FilteredTodosLoading extends FilteredTodosState {
  @override
  String toString() => 'FilteredTodosLoading';
}

class FilteredTodosLoaded extends FilteredTodosState {

  final VisibilityFilter activeFilter;
  final List<Todo> todos;

  FilteredTodosLoaded({ this.activeFilter, this.todos }): super([activeFilter, todos]);


  @override
  String toString() => 'FilteredTodosLoaded($activeFilter)';
}