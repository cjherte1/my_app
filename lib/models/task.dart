import 'package:flutter/cupertino.dart';

class Task extends StatefulWidget {
  int id;
  String name;
  int date;
  int time;
  String description;

  Task(this.id, this.name, this.date, this.time, this.description);


  getName() => name;		//return name given by ID
  getDate() => date;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}