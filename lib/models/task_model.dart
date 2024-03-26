class TaskModel {
  String? id;
  String? title;
  String? description;
  static const String collectionName = 'Tasks';
  DateTime date;
  bool? isDone;
  String userId;

  TaskModel({
    this.id = "",
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
  });
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title'],
          userId: json['userId'],
          description: json['description'],
          date: DateTime.fromMillisecondsSinceEpoch(json['date']),
          id: json['id'],
          isDone: json['isDone'],
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'userId': userId,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      "id": id,
      "isDone": isDone,
    };
  }
}
