import 'package:flutter/material.dart';
import 'package:flutter_tasklist/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task(
        'Study Flutter this is a very very long lorem ipsum to test how it adapts to size and overflow',
        'assets/images/flutter_dash.png',
        3),
    Task('Ride my bike', 'assets/images/bike.jpg', 1),
    Task('Meditate', 'assets/images/meditate.jpeg', 5),
    Task('Read', 'assets/images/read.jpg', 4),
    Task('Play video-games', 'assets/images/playing.jpg', 1),
    Task('Gym', 'assets/images/gym.png', 3),
    Task('Dance salsa', 'assets/images/salsa.jpg', 4),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
