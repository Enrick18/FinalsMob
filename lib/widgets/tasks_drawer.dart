import 'package:final_mob/bloc/taskBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/taskState.dart';
import '../bloc/themeBloc.dart';
import '../bloc/themeState.dart';
import '../screens/recycle_bin_screen.dart';
import '../screens/tabs_screen.dart';


class TasksDrawer extends StatelessWidget {
  const TasksDrawer({Key? key}) : super(key: key);

  _switchToDarkTheme(BuildContext context, bool isDarkTheme) {
    context.read<ThemeBloc>().add(ToggleTheme(isDarkTheme: isDarkTheme));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.folder_special),
              title: const Text('My Tasks'),
              trailing:BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  final pendingTasks = state.pendingTasks!;
                  final completedTasks = state.completedTasks!;
                  return Text(
                    '${pendingTasks.length} | ${completedTasks.length}',
                  );
                },
              ),
              onTap: () => Navigator.pushReplacementNamed(
                context,
                TabsScreen.path,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Recycle Bin'),
              trailing:  BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  final removedTasks = state.removedTasks!;
                  return Text('${removedTasks.length}');
                },
              ),
              onTap: () => Navigator.pushReplacementNamed(
                context,
                RecycleBinScreen.path,
              ),
            ),
            const Divider(),
            const Expanded(child: SizedBox()),
            BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
              return ListTile(
                leading: Switch(
                  value: state.isDarkTheme!,
                  onChanged: (newValue) =>
                      _switchToDarkTheme(context, newValue),
                ),
                title: const Text('Switch to Dark Theme'),
                onTap: () => _switchToDarkTheme(context, !state.isDarkTheme!),
              );
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
