class Task{
  final String id;
  final String title;
  final String status;
  final String priority;
  final String assignedTo;
  final DateTime dueDate;
  final String description;
  final double estimateHours;
  final DateTime createdAt;

  Task({required this.id, required this.title, required this.status, required this.priority,
    required this.assignedTo, required this.dueDate, required this.description, required this.estimateHours, required this.createdAt
  });

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      priority: json['priority'],
      assignedTo: json['assigned_to'],
      dueDate: DateTime.parse(json['due_date']),
      description: json['description'],
      estimateHours: json['estimate_hours'],
      createdAt: DateTime.parse(json['created_at'])
    );
  }
}