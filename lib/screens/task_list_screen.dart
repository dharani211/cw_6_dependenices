// lib/screens/task_list_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
import '../models/widgets/task_tile.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();

  // Initialize Firestore collection reference
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  String _selectedPriority = "Medium"; // Default priority for new tasks
  String _filterPriority = "All"; // Filter option for priority
  bool _showCompletedOnly = false; // Filter option for completed tasks only

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  // Add a task to Firestore with name and priority
  Future<void> _addTask(String name) async {
    if (name.isEmpty) return;

    // Create a new Task instance
    Task newTask = Task(id: '', name: name, priority: _selectedPriority);

    try {
      // Add to Firestore; the Firestore document ID will be generated automatically
      await tasksCollection.add(newTask.toFirestore());

      // Clear the task controller and reset priority after adding
      _taskController.clear();
      setState(() {
        _selectedPriority = "Medium";
      });
    } catch (e) {
      print("Error adding task: $e"); // Handle errors
    }
  }

  // Update task completion status in Firestore
  Future<void> _updateTaskCompletion(Task task) async {
    try {
      // Toggle `isCompleted` field
      await tasksCollection.doc(task.id).update({
        'isCompleted': !task.isCompleted,
      });
    } catch (e) {
      print("Error updating task completion: $e"); // Handle errors
    }
  }

  // Delete task from Firestore by document ID
  Future<void> _deleteTask(String taskId) async {
    try {
      await tasksCollection.doc(taskId).delete();
    } catch (e) {
      print("Error deleting task: $e"); // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          // Dropdown for filtering tasks by priority
          DropdownButton<String>(
            value: _filterPriority,
            items: ["All", "High", "Medium", "Low"]
                .map((priority) => DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _filterPriority = value!;
              });
            },
          ),
          // Toggle for completed tasks
          IconButton(
            icon: Icon(_showCompletedOnly
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            onPressed: () {
              setState(() {
                _showCompletedOnly = !_showCompletedOnly;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration:
                        const InputDecoration(labelText: 'Enter task name'),
                    onSubmitted: _addTask,
                  ),
                ),
                // Dropdown for setting task priority when adding a new task
                DropdownButton<String>(
                  value: _selectedPriority,
                  items: ["High", "Medium", "Low"]
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addTask(_taskController.text),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  tasksCollection.snapshots(), // Real-time Firestore listener
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Transform documents to Task objects and filter/sort
                final tasks = snapshot.data!.docs.map((doc) {
                  // Update Task from Firestore and attach document ID
                  return Task.fromFirestore(doc).copyWith(id: doc.id);
                }).where((task) {
                  if (_filterPriority != "All" &&
                      task.priority != _filterPriority) {
                    return false;
                  }
                  if (_showCompletedOnly && !task.isCompleted) {
                    return false;
                  }
                  return true;
                }).toList();

                // Sort tasks by priority and completion status
                tasks.sort((a, b) {
                  const priorityOrder = {"High": 0, "Medium": 1, "Low": 2};
                  int priorityComparison = priorityOrder[a.priority]!
                      .compareTo(priorityOrder[b.priority]!);
                  if (priorityComparison != 0) return priorityComparison;
                  return a.isCompleted == b.isCompleted
                      ? 0
                      : (a.isCompleted ? 1 : -1);
                });

                if (tasks.isEmpty) {
                  return const Center(child: Text("No tasks available."));
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskTile(
                      task: task,
                      onCheckboxChanged: () => _updateTaskCompletion(task),
                      onDelete: () => _deleteTask(task.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
