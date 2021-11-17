import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/task.dart';
import '../database_helper.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';


/*
CREATES A CARD WIDGET FOR EACH TASK
just formats the task information into a box
 */
Widget taskCard(task) {
  DateTime dt = DateTime.parse(task.datetime);
  String formattedDate = DateFormat('MMMM d, yyyy - h:mm a').format(dt).toString();
  return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              task.name,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ));
}

class CreateTasks extends StatefulWidget {
  const CreateTasks({Key? key}) : super(key: key);

  @override
  State<CreateTasks> createState() => _CreateTasksState();
}

// Future<List<Task>> getTasks(User user) =>
//     Future<List<Task>>.delayed(const Duration(seconds: 1), () async {
//       var tasks = await DatabaseHelper.instance.getTasksByUser(user.id);
//       user.tasks = tasks;
//       return tasks;
//     });

class _CreateTasksState extends State<CreateTasks> {
  bool pressed = false;

  final nameController = TextEditingController();
  final datetimeController = TextEditingController();
  final descriptionController = TextEditingController();
  final userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;
    //List utasks = currentUser.tasks.where((isCompleted) => true).toList();
    // Future<List<Task>> tasks = getTasks(currentUser);
    // return FutureBuilder<List<Task>>(
    //   future: tasks,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    return ListView(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Text(
            'Welcome ' + currentUser.firstName + '!',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            //TO DO: ONLY SHOW TAKS FOR THAT DAY
            children: currentUser.tasks.map((task) => taskCard(task)).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              pressed ? const CreateTasksForm() : const SizedBox(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFF29765),
                    textStyle: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                child: pressed ? const Text("Go Back") : const Text("Add Task"),
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                },
              )
            ],
          ),
        ],
      ),
    ]);
  }

  //       return const Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }
}

class CreateTasksForm extends StatefulWidget {
  const CreateTasksForm({Key? key}) : super(key: key);

  @override
  CreateTasksFormState createState() {
    return CreateTasksFormState();
  }
}

class CreateTasksFormState extends State<CreateTasksForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final datetimeController = TextEditingController();
  final descriptionController = TextEditingController();
  final userIdController = TextEditingController();
  DateTime year = DateTime(DateTime.now().year);

  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: nameController,
              validator: nameValidator.validate,
              decoration: const InputDecoration(
                labelText: 'Task Name',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Container(
          //   padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          //   child: TextFormField(
          //     controller: datetimeController,
          //     validator: datetimeValidator.validate,
          //     decoration: const InputDecoration(
          //       labelText: 'Date and Time',
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: descriptionController,
              validator: descriptionValidator.validate,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // DateTimePicker(
          //   type: DateTimePickerType.date,
          //   //dateMask: 'yyyy/MM/dd',
          //   // controller: _controller3,
          //   //initialValue: _initialValue,
          //   firstDate: year,
          //   lastDate: DateTime(2100),
          //   icon: Icon(Icons.event),
          //   dateLabelText: 'Date',
          //   locale: Locale('en', 'US'),
          //   //onChanged: (val) => setState(() => _valueChanged3 = val),
          //   // validator: (val) {
          //   //  setState(() => _valueToValidate3 = val ?? '');
          //   //  return null;
          //   //  },
          //   //  onSaved: (val) => setState(() => _valueSaved3 = val ?? ''),
          // ),
          DateTimePicker(
            type: DateTimePickerType.dateTime,
            dateMask: 'MMMM d, yyyy - h:mm a',
            controller: datetimeController,
            //timePickerEntryModeInput: true,
            //controller: _controller4,
            firstDate: DateTime(2021),
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateLabelText: 'Date Time',
            use24HourFormat: false,
            locale: Locale('en', 'US'),
            validator: datetimeValidator.validate,
          ),



          SizedBox(height: 30),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF29765),
              ),
              child: const Text(
                'Create task',
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {


                if (_formKey.currentState!.validate()) {
                  Task task = Task(
                    currentUser.taskCount,
                    nameController.text,
                    datetimeController.text,
                    descriptionController.text,
                    currentUser.id,
                  );

                  addTask(currentUser, task);

                  await DatabaseHelper.instance.addTask(
                    //I HAVE NO IDEA HOW TO CALL THE FUNCTION FROM THE DATABASE HELPER LOL PLS HELP
                    nameController.text, datetimeController.text,
                    descriptionController.text, currentUser.id,
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            "Successfully added task."),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }),
        ],
      ),
    );
  }
}

class nameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a task name';
    }
    return null;
  }
}

//TO DO: validate date and time in correct format.
class datetimeValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date and time';
    } else {
      return null;
    }
  }
}

class descriptionValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }
}
