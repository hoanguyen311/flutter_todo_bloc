import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';
import '../bloc/todos/todos.dart';

class NewTodoForm extends StatefulWidget {
  static String routeName = '/new-todo';

  @override
  State<StatefulWidget> createState() => _NewTodoFormState();
}

class _NewTodoFormState extends State<NewTodoForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('New Todo'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Task'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter task title';
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                    labelText: 'Note'
                )
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text('Create New Todo'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    todoBloc.dispatch(
                      AddTodo(
                        Todo(
                          _taskController.text,
                          note: _noteController.text
                        )
                      )
                    );

                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        ),
      )
    );
  }
}
