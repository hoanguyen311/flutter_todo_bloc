import 'package:equatable/equatable.dart';
import '../../models/models.dart';

class FilteredTodosEvent extends Equatable {
  FilteredTodosEvent([props = const []]): super(props);
}

class UpdateFilter extends FilteredTodosEvent {
  UpdateFilter(this.activeFilter);

  final VisibilityFilter activeFilter;
}

class UpdateTodos extends FilteredTodosEvent {
  List<Todo> todos;

  UpdateTodos(this.todos);
}