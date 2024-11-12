// lib/models/task.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String name;
  final bool isCompleted;
  final String priority;

  Task({
    required this.id,
    required this.name,
    this.isCompleted = false,
    this.priority = "Medium",
  });

  // Factory constructor to create a Task from Firestore document data
  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return Task(
      id: doc.id,
      name: data?['name'] ?? '',
      isCompleted: data?['isCompleted'] ?? false,
      priority: data?['priority'] ?? "Medium",
    );
  }

  // Method to convert a Task to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'isCompleted': isCompleted,
      'priority': priority,
    };
  }

  // copyWith method for creating a modified copy of the Task
  Task copyWith({
    String? id,
    String? name,
    bool? isCompleted,
    String? priority,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
    );
  }
}
