// lib/widgets/task_tile.dart

import 'package:cw6/models/task.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onCheckboxChanged;
  final VoidCallback onDelete;

  const TaskTile({
    Key? key,
    required this.task,
    required this.onCheckboxChanged,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the color based on priority
    Color priorityColor;
    switch (task.priority) {
      case 'High':
        priorityColor = Colors.red;
        break;
      case 'Medium':
        priorityColor = Colors.orange;
        break;
      case 'Low':
      default:
        priorityColor = Colors.green;
    }

    return ListTile(
      title: Text(
        task.name,
        style: TextStyle(
          color: priorityColor, // Apply color based on priority
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "Priority: ${task.priority}",
        style: TextStyle(
          color: priorityColor,
        ),
      ),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) => onCheckboxChanged(),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
