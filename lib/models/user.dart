import './task.dart';

class User {

  String firstName;
  String lastName;
  String username;
  String password;
  int taskCount = 0; //number of task for user
  List tasks = [];

  User(this.firstName, this.lastName, this.username, this.password);

  //return First and Last name
  getName() => firstName + ' ' + lastName;

  getUserName() => username;

  getPassword() => password;

  // return tasks as a list
  getTasks() => tasks;

  //add new task to map
  addTasks(Task task) => tasks.add(task);

  //remove task given the name
  deleteTasks(String name) => tasks.removeWhere((item) => item.name == name);


  //createTaskMap():


}
