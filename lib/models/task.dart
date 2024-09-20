import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Task {
  final int id;
  final String title;
  bool done = false;
  late DatabaseReference _id;

  Task({
    required this.id,
    required this.title,
    this.done = false,
  });

  factory Task.fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      title: taskMap['title'],
      done: taskMap['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': this.id,
      'title': this.title,
      'done': this.done
    };
  }

  Task fromJson(Map<String, dynamic> json) {
    return Task(id: json['id'], title: json['title'], done: json['done']);
  }

  void toggle() {
    done = !done;
  }


  DatabaseReference get idRef => _id;

  void setId(DatabaseReference value) {
    _id = value;
  }
}
