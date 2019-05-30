import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todos/todos.dart';
import '../models/models.dart';

class Details extends StatefulWidget {

  static final String routeName = '/details';

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController _taskController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  bool _complete = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration.zero, () {
      final Todo todo = ModalRoute.of(context).settings.arguments;
      print(todo);

      setState(() {
        _taskController = TextEditingController(text: todo.task);
        _noteController = TextEditingController(text: todo.note);
        _complete = todo.complete;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Todo todo = ModalRoute.of(context).settings.arguments;
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.task),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    labelText: 'Task'
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Task can not be empty';
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
                CheckboxListTile(
                  title: Text('Complete'),
                  value: _complete,
                  onChanged: (value) {
                    setState(() {
                      _complete = value;
                    });
                }),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      child: Text('Delete'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            todoBloc.dispatch(
                              DeleteTodo(todo)
                            );
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      child: Text('Edit Todo'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          todoBloc.dispatch(
                              UpdateTodo(
                                  todo.copyWith(
                                      complete: _complete,
                                      task: _taskController.text,
                                      note: _noteController.text
                                  )
                              )
                          );
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
