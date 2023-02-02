class Task {
  int? id;
  String? title;
  String? note;
  String? date;
  String? startTime;

  int? color;
  int? isCompleted;
  int? remind;
  String? repeat;

  Task({
    this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.remind,
    required this.repeat,
    required this.color,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'date': date,
      'startTime': startTime,
      'remind': remind,
      'repeat': repeat,
      'color': color,
      'isCompleted': isCompleted,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    remind = json['remind'];
    repeat = json['repeat'];
    color = json['color'];
    isCompleted = json['isCompleted'];
  }
}
