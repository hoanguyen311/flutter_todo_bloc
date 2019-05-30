import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bloc_todo/models/todo.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

import 'package:bloc_todo/bloc/todos/todos_event.dart';
import 'package:bloc_todo/bloc/todos/todos_state.dart';

class TodoBloc extends Bloc<TodosEvent, TodosState> {
  TodosRepositoryFlutter todoRepository;

  TodoBloc({
    @required this.todoRepository
  });

  @override
  TodosState get initialState => TodosLoading();

  List<Todo> get currentTodos => (currentState as TodosLoaded).todos;

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final todosEntity = await todoRepository.loadTodos();
      final todosList = todosEntity.map((entity) => Todo.fromEntity(entity)).toList();

      yield TodosLoaded(todosList);
    } catch(_) {
      yield TodosUnloaded();
    }
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    final currentTodos = List<Todo>.from(this.currentTodos)..add(event.todo);
    yield TodosLoaded(currentTodos);
    _saveTodos(currentTodos);
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (!(currentState is TodosLoaded)) {
      return;
    }

    final updatedTodos = (currentState as TodosLoaded).todos.map((item) {
      if (item.id == event.updatedTodo.id) {
        return event.updatedTodo;
      }
      return item;
    }).toList();

    yield TodosLoaded(updatedTodos);
    _saveTodos(updatedTodos);
  }

  Stream<TodosState> _mapClearCompletedToState(ClearCompleted event) async* {
    final newTodos = List<Todo>.from(this.currentTodos).where((todo) => !todo.complete).toList();

    yield TodosLoaded(newTodos);
    _saveTodos(newTodos);
  }

  void _saveTodos(List<Todo> todos) {
    todoRepository.saveTodos(todos.map((Todo todo) => todo.toEntity()).toList());
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    final newTodos = List<Todo>.from(this.currentTodos).where((todo) => todo.id != event.todo.id).toList();

    yield TodosLoaded(newTodos);

    _saveTodos(newTodos);
  }

}