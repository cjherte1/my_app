class Task{
  int id;
  String name;
  int date;
  int time;
  String description;

  Task(this.id, this.name, this.date, this.time, this.description);


  getName() => name;		//return name given by ID
  getDate() => date;

}