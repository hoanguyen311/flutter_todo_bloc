import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/filtered_todos/filtered_todos.dart';
import '../models/models.dart';

class FilterDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filteredTodosBloc = BlocProvider.of<FilteredTodosBloc>(context);


    return BlocBuilder<FilteredTodosEvent, FilteredTodosState>(
      bloc: filteredTodosBloc,
      builder: (context, currentState) {

        return PopupMenuButton<VisibilityFilter>(
          icon: Icon(
            Icons.filter_list
          ),
          onSelected: (activeFilter) {
            filteredTodosBloc.dispatch(UpdateFilter(activeFilter));
          },
          itemBuilder: (context) {
            return VisibilityFilter.values.map((item) {
              return PopupMenuItem<VisibilityFilter>(
                value: item,
                child: Text(getTitle(item)),
              );
            }).toList();
          },
        );
      },
    );
  }

  String getTitle(VisibilityFilter filter) {
    switch(filter) {
      case VisibilityFilter.active:
        return 'Active';
      case VisibilityFilter.completed:
        return 'Completed';
      case VisibilityFilter.all:
      default:
      return 'All';
    }
  }
}
