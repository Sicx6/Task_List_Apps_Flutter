import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Task {
  String title;
  String description;
  String author;
  String? id;
  DateTime? createdDate;
  String authorId;
  bool completed;

  Task(
      {required this.title,
      required this.description,
      required this.author,
      required this.authorId,
      this.completed = false,
      this.createdDate,
      this.id});

  static Task fromMap(Map<String, dynamic> data, {String? id}) {
    try {
      return Task(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        author: data['author'] ?? '',
        id: id,
        createdDate: (data['createdDate'] as Timestamp).toDate(),
        authorId: data['authorId'] ?? '',
        completed: data['completed'] ?? false,
      );
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'author': author,
      'createdDate': createdDate,
      'authorId': authorId,
      'completed': completed,
    };
  }

  get dateInString {
    return DateFormat('d/M/y').add_jm().format(createdDate!);
  }
}
