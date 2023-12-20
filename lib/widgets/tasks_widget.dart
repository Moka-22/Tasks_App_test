import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasks/themes/colors.dart';

class TasksItemWidget extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TasksItemWidget({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: taskRed,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              // check box
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: taskBlue,
              ),
              // Task Name
              Text(
                taskName,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: taskBackGround,
                  fontSize: 18,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: taskWhite,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: taskBackGround,
            ),
          ),
        ),
      ),
    );
  }
}
