import 'package:hive_flutter/hive_flutter.dart';

class TasksDataBase {
  // List of tasks
  List taskList = [];
  // reference box
  final _myBox = Hive.box('mybox');

  // when opening the app for first time
  void createIntitialData() {
    taskList = [
      ['New Task', false]
    ];
  }

  // get data from database
  void getdata() {
    taskList = _myBox.get('TaskList');
  }

  // update database
  void updateDataBase() {
    _myBox.put('TaskList', taskList);
  }
}
