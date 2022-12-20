import 'package:flutter_tasklist/data/database.dart';
import 'package:sqflite/sqflite.dart';
import '../components/task.dart';

class TaskDAO {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task task) async {
    print('Accessing save()');
    final Database dataBase = await getDatabase();

    var itemExists = await find(task.name);
    Map<String,dynamic> taskMap = toMap(task);

    if (itemExists.isEmpty) {
      print('The task did not exist');
      return await dataBase.insert(_tablename, taskMap);
    } else {
      print('The task already existed');
      return await dataBase.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [task.name],
      );
    }
  }

  Future<List<Task>> findAll() async {
    print('Accessing findAll()');
    final Database dataBase = await getDatabase();

    final List<Map<String, dynamic>> result = await dataBase.query(_tablename);
    print('Looking for data in the database. Found: $result');

    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    print('Converting Maps to List of Tasks');
    final List<Task> tasks = [];

    for (Map<String, dynamic> line in taskMap) {
      final Task task = Task(line[_name], line[_image], line[_difficulty]);
      tasks.add(task);
    }
    print('TaskList: $tasks');
    return tasks;
  }

  Map<String,dynamic> toMap(Task task){
    print('Converting Task to Map');
    final Map<String,dynamic> taskMap = {};
    taskMap[_name] = task.name;
    taskMap[_image] = task.photo;
    taskMap[_difficulty] = task.difficulty;
    print('TaskMap: $taskMap');

    return taskMap;
  }

  Future<List<Task>> find(String taskName) async {
    print('Accessing find()');
    final Database dataBase = await getDatabase();

    final List<Map<String, dynamic>> result = await dataBase.query(_tablename,
        where: '$_name = ?',
        whereArgs: [taskName]);
    print('Found the task: ${toList(result)}');

    return toList(result);
  }

  delete(String taskName) async {
    print('Accessing delete()');
    final Database dataBase = await getDatabase();

    return dataBase.delete(_tablename,
      where: '$_name = ?',
      whereArgs: [taskName]
    );
  }
}
