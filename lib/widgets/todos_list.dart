import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';

import '../models/models.dart';
import '../bloc/todos/todos.dart';
import '../bloc/filtered_todos/filtered_todos.dart';
import './loader.dart';
import '../screens/screens.dart';

class TodosList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    FilteredTodosBloc filteredTodoBloc = BlocProvider.of<FilteredTodosBloc>(context);

    return BlocBuilder<FilteredTodosEvent, FilteredTodosState>(
      bloc: filteredTodoBloc,
      builder: (context, state) {
        if (state is FilteredTodosLoading) {
          return Loader();
        } else if (state is FilteredTodosLoaded) {
          return _buildList(state.todos);
        }
      },
    );
  }

  Widget _buildList(List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, i) {
        return TodoItem(
          todo: todos[i],
          onChangeComplete: () {
            _handleChangeComplete(todos[i], context);
          },
          onDelete: (_) {
            _handleDismiss(todos[i], context);
          },
        );
      },
    );
  }

  _handleChangeComplete(Todo todo, BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    todoBloc.dispatch(
      UpdateTodo(todo.copyWith(
        complete: !todo.complete
      ))
    );
  }

  _handleDismiss(Todo todo, BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    todoBloc.dispatch(
      DeleteTodo(todo)
    );

    final snackBar = SnackBar(
      backgroundColor: Colors.deepOrange,
      content: Text('Todo item with id: "${todo.id}" has been deleted'),
      action: SnackBarAction(label: 'Undo', onPressed: () {
        todoBloc.dispatch(
          AddTodo(todo)
        );
      }),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}


class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onChangeComplete;
  final Function onDelete;

  TodoItem({ @required this.todo, this.onChangeComplete, this.onDelete });

  @override
  Widget build(BuildContext context) {
    final title = Text(
        todo.task,
      style: TextStyle(
        fontSize: 20
      ),
    );
    final checkbox = Checkbox(
      key: ArchSampleKeys.todoItemCheckbox(todo.id),
      value: todo.complete,
      onChanged: (_) {
        onChangeComplete();
      });

    final onTap = () {
      Navigator.of(context).pushNamed(Details.routeName, arguments: todo);
    };
    final tile = todo.note.isNotEmpty ? ListTile(
      leading: checkbox,
      title: title,
      onTap: onTap,
      subtitle: Text(
          todo.note
      ),
    ) : ListTile(
        onTap: onTap,
        leading: checkbox,
        title: title
    );

    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ArchSampleKeys.todoItem(todo.id),
      onDismissed: onDelete,
      child: tile
    );
  }
}

