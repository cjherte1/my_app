class Task {
  int id = 0;
  String name;
  String datetime;
  String description;
  int isCompleted = 0;
  int userId;

  Task(this.name, this.datetime, this.description, this.userId);

  getName() => name; //return name given by ID
  getDate() => datetime;

  Task.fromMap(Map<String, dynamic> map)
      : id = map['taskId'],
        name = map['name'],
        datetime = map['datetime'],
        description = map['description'],
        isCompleted = map['isCompleted'],
        userId = map['userId'];
}
