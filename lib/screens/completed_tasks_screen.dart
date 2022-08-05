import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/taskBloc.dart';
import '../bloc/taskState.dart';
import '../widgets/tasks_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label:  BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  final completeTasks = state.completedTasks!;
                  return Text('${completeTasks.length} Tasks');
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              final completeTasks = state.completedTasks!;
              return TasksList(tasksList: completeTasks);
            },
          ),
        ],
      ),
    );
  }
}
