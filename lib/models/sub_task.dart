// lib/models/sub_task.dart

class SubTask {
  String name;
  DateTime startTime;
  DateTime endTime;

  SubTask({
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
