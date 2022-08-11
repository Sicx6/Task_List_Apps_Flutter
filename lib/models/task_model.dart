class Task {
  String title;
  String description;
  String author;

  Task({required this.title, required this.description, required this.author});

  static Task fromMap(Map<String, dynamic> data) {
    return Task(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        author: data['author'] ?? '');
  }

  Map<String, Object> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
