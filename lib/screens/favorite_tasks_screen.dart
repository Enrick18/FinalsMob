import 'package:final_mob/bloc/taskBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/taskState.dart';
import '../widgets/tasks_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  final favoriteTasks = state.favoriteTasks!;
                  return Text('${favoriteTasks.length} Tasks');
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              final tasks = state.favoriteTasks!;
              return TasksList(tasksList: tasks);
            },
          ),
        ],
      ),
    );
  }
}
