import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';
import '../bloc/todos/todos.dart';
import '../bloc/filtered_todos/filtered_todos.dart';
import './new.dart';

class Home extends StatefulWidget {
  final VoidCallback onInit;
  static String routeName = '/';

  Home({ @required this.onInit });

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FilteredTodosBloc filteredTodosBloc;
  
  @override
  void initState() {
    widget.onInit();
    filteredTodosBloc = FilteredTodosBloc(
        todosBloc: BlocProvider.of<TodoBloc>(context)
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilteredTodosBloc>(
      bloc: filteredTodosBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          actions: <Widget>[
            FilterDropdown()
          ],
        ),
        body: TodosList(),
        floatingActionButton: IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Theme.of(context).appBarTheme.color,
            ),
            iconSize: 40,
            onPressed: () {
              Navigator.of(context).pushNamed(NewTodoForm.routeName);
            }),
      ),
    );
  }

  @override
  void dispose() {
    filteredTodosBloc.dispose();
    super.dispose();
  }
}
