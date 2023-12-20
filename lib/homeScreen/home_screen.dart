import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks/database/database.dart';
import 'package:tasks/themes/colors.dart';
import 'package:tasks/widgets/task_box.dart';
import 'package:tasks/widgets/tasks_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // hive box
  final _myBox = Hive.box('mybox');
  // database
  TasksDataBase db = TasksDataBase();
  // text controller
  final _controller = TextEditingController();
  // search controller
  TextEditingController _searchController = TextEditingController();
// opening the app for first time
  @override
  void initState() {
    if (_myBox.get('TaskList') == null) {
      db.createIntitialData();
      // already exist
    } else {
      db.getdata();
    }
    super.initState();
  }

  // filter item
  List get filteredTaskList {
    if (_searchController.text.isEmpty) {
      return db.taskList;
    } else {
      return db.taskList
          .where((task) => task[0]
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: taskWhite,
      // AppBar
      appBar: AppBar(
        backgroundColor: taskWhite,
        elevation: 0.0,
        title: Text(
          'Tasks',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: taskBackGround,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: taskBackGround,
                    size: 20,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 20,
                    minWidth: 25,
                  ),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: taskBackGround,
                  ),
                ),
              ),
            ),
            // Text
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 20),
              child: Text(
                'All Tasks',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: taskBackGround,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTaskList.length,
                itemBuilder: (context, index) {
                  return TasksItemWidget(
                    taskName: filteredTaskList[index][0],
                    taskCompleted: filteredTaskList[index][1],
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (BuildContext) => deleteTask(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: taskBlue,
        elevation: 0,
        foregroundColor: taskWhite,
        onPressed: createNewTask,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  // checkbox changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.taskList[index][1] = !db.taskList[index][1];
    });
    db.updateDataBase();
  }

  // Save New Task
  void saveNewTask() {
    setState(() {
      db.taskList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // New task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return TaskBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateDataBase();
  }

  // delete Task
  void deleteTask(int index) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updateDataBase();
  }
}
