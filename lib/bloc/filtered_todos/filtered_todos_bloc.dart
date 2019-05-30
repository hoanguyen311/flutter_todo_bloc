import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc_todo/bloc/todos/todos_bloc.dart';
import 'package:bloc_todo/bloc/todos/todos_state.dart';
import 'package:bloc_todo/bloc/filtered_todos/filtered_todos_state.dart';
import 'package:bloc_todo/bloc/filtered_todos/filtered_todos_event.dart';
import 'package:bloc_todo/models/models.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  StreamSubscription todosSubscription;
  final TodoBloc todosBloc;


  @override
  FilteredTodosState get initialState {

    if (todosBloc.currentState is TodosLoaded) {
      return FilteredTodosLoaded(
          todos: (todosBloc.currentState as TodosLoaded).todos,
          activeFilter: VisibilityFilter.all
      );
    }

    return FilteredTodosLoading();
  }

  FilteredTodosBloc({ @required this.todosBloc }) {
    todosSubscription = todosBloc.state.listen((state) {
      if (state is TodosLoaded) {
        dispatch(UpdateTodos((todosBloc.currentState as TodosLoaded).todos));
      }
    });
  }

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    }

    if (event is UpdateTodos) {
      yield* _mapUpdateTodosToState(event);
    }
  }

  @override
  Stream<FilteredTodosState> _mapUpdateFilterToState(UpdateFilter event) async* {
    yield FilteredTodosLoaded(
      activeFilter: event.activeFilter,
      todos: filterTodos(
          (todosBloc.currentState as TodosLoaded).todos,
        event.activeFilter
      )
    );
  }

  @override
  Stream<FilteredTodosState> _mapUpdateTodosToState(UpdateTodos event) async* {
    VisibilityFilter activeFilter = currentState is FilteredTodosLoaded ? (currentState as FilteredTodosLoaded).activeFilter : VisibilityFilter.all;

    yield FilteredTodosLoaded(
        activeFilter: activeFilter,
        todos: filterTodos(
            event.todos,
            activeFilter
        )
    );
  }

  List<Todo> filterTodos(List<Todo> todos, VisibilityFilter activeFilter) {
    switch(activeFilter) {
      case VisibilityFilter.completed:
        return todos.where((todo) => todo.complete).toList();
      case VisibilityFilter.active:
        return todos.where((todo) => !todo.complete).toList();
      case VisibilityFilter.all:
      default:
        return todos;
    }
  }

  void dispose() {
    todosSubscription.cancel();
    super.dispose();
  }
}