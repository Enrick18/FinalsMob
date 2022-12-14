import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/taskBloc.dart';
import '../models/task.dart';
import 'add_edit_task.dart';
import 'popup_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);

  final Task task;

  _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddEditTask(task: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              task.isFavorite == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration:
                            task.isDone! ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Text(
                      DateFormat()
                          .add_yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.createdAt!)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted! ? null : (value) {
                  // TODO: Implement Complete Task
                  print(value);
                  final completeTask = Task(
                      id: task.id,
                      title: task.title,
                      description: task.description,
                      createdAt: task.createdAt,
                      isFavorite: task.isFavorite,
                      isDone: value);
                  context
                      .read<TaskBloc>()
                      .add(CompleteTask(task: completeTask));
                }),
            PopupMenu(
              task: task,
              editCallback: () {
                Navigator.pop(context);
                _editTask(context);
              },
              likeOrDislikeCallback: () {
                final favoriteTask = Task(
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    createdAt: task.createdAt,
                    isFavorite: !task.isFavorite!,
                    isDone: task.isDone);
                context.read<TaskBloc>().add(AddToFavorite(task: favoriteTask));
              },
              cancelOrDeleteCallback: () {
                final deleteTask = Task(
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    createdAt: task.createdAt,
                    isFavorite: task.isFavorite,
                    isDone: task.isDone,
                    isDeleted: !task.isDeleted!);
                context.read<TaskBloc>().add(DeleteTask(task: deleteTask));
              },
              restoreTaskCallback: () {
                final restoreTask = Task(
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    createdAt: task.createdAt,
                    isFavorite: task.isFavorite,
                    isDone: task.isDone,
                    isDeleted: !task.isDeleted!);
                context.read<TaskBloc>().add(RestoreTask(task: restoreTask));
              },
            ),
          ],
        ),
      ],
    );
  }
}
