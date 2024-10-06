import 'dart:convert';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  int? taskId;

  @HiveField(1)
  String? taskTitle;

  @HiveField(2)
  String? taskDescription;

  @HiveField(3)
  DateTime? deadline;

  @HiveField(4)
  int? isCompleted;

  @HiveField(5)
  DateTime? createdAt;

  @HiveField(6)
  int? projectId;

  TaskModel({
    this.taskId,
    this.taskTitle,
    this.taskDescription,
    this.deadline,
    this.isCompleted,
    this.createdAt,
    this.projectId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    taskId: json["task_id"],
    taskTitle: json["task_title"],
    taskDescription: json["task_description"],
    deadline: json["deadline"] == null ? null : DateTime.parse(json["deadline"]),
    isCompleted: json["is_completed"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    projectId: json["project_id"],
  );

  Map<String, dynamic> toJson() => {
    "task_id": taskId,
    "task_title": taskTitle,
    "task_description": taskDescription,
    "deadline": deadline?.toIso8601String(),
    "is_completed": isCompleted,
    "created_at": createdAt?.toIso8601String(),
    "project_id": projectId,
  };
}

// To parse this JSON data
List<TaskModel> taskModelFromJson(String str) => List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
