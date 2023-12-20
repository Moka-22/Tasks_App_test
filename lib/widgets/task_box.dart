import 'package:flutter/material.dart';
import 'package:tasks/themes/colors.dart';
import 'package:tasks/widgets/button_widegt.dart';

class TaskBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  TaskBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: taskWhite,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Enter New Task
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add A New Task',
                hintStyle: TextStyle(
                  color: taskBackGround,
                ),
              ),
            ),
            // Actions Bottoms
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Save
                Container(
                  width: 90,
                  height: 35,
                  color: taskBlue,
                  child: IconButton(
                    onPressed: onSave,
                    icon: Text(
                      'Save',
                      style: TextStyle(
                        color: taskWhite,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // cancel
                Container(
                    width: 90,
                    height: 35,
                    color: taskBlue,
                    child: IconButton(
                      onPressed: onCancel,
                      icon: Text(
                        'Cancel',
                        style: TextStyle(
                          color: taskWhite,
                        ),
                      ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
