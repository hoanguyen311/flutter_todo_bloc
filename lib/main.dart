import 'package:flutter/material.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import './screens/screens.dart';
import './bloc/todos/todos.dart';
import './bloc/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(App());
}

class App extends StatelessWidget {

  final TodoBloc todoBloc = TodoBloc(
      todoRepository: const TodosRepositoryFlutter(
          fileStorage: const FileStorage('__flutter_bloc_app__', getApplicationDocumentsDirectory)
      )
  );


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: todoBloc,
      child:  MaterialApp(
        theme: ThemeData.dark(),
        routes: {
          Home.routeName: (context) => Home(
            onInit: handleInit,
          ),
          NewTodoForm.routeName: (context) => NewTodoForm(),
          Details.routeName: (context) => Details()
        },
      )
    );
  }

  void handleInit() {
    todoBloc.dispatch(LoadTodos());
  }
}

