class Task {
  String title;
  String description;
  String author;
  String? id;

  Task(
      {required this.title,
      required this.description,
      required this.author,
      this.id});

  static Task fromMap(Map<String, dynamic> data, {String? id}) {
    return Task(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      author: data['author'] ?? '',
      id: id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'author': author,
    };
  }
}
