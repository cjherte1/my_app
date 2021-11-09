import './task.dart';

class User {

  int id;
  String firstName;
  String lastName;
  String username;
  String password;
  int taskCount = 0; //number of task for user
  List<Task> tasks = [];

  User(this.id, this.firstName, this.lastName, this.username, this.password);

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

  Map<String, dynamic> toMap(){
    return {
      'firstname': firstName,
      'lastname': lastName,
      'username': username,
      'password': password,
    };
  }

  User.fromMap(Map<String, dynamic> map): id = map['userId'], firstName = map['firstName'],
        lastName = map['lastName'], username = map['username'],
        password = map['password'];

  @override
  String toString(){
    return 'User{firstname: $firstName, lastname: $lastName, username: '
        '$username, password: $password}';
  }
}
  //createTaskMap():

List<User> users = [];
int userNum = 0;

User getUserByUserName(String username){
  var user;
  for (var u in users){
    if (u.username == username){
      user = u;
    }
  }
  return user;
}

User getUserByID(int userID){
  var user;
  for (var u in users){
    if (u.id == userID){
      user = u;
    }
  }
  return user;
}

void addUser(User user){
  ++userNum;
  users.add(user);
}

void deleteUser(User user){
  --userNum;
  users.remove(user);
}

int getUserTotal(){
  return userNum;
}