import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/task.dart';
import '../database_helper.dart';
import 'package:date_time_picker/date_time_picker.dart';

/*
CREATES A CARD WIDGET FOR EACH TASK
just formats the task information into a box
 */
Widget taskCard(task) {
  return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              task.datetime,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.0),
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

Future<List<Task>> getTasks(User user) =>
    Future<List<Task>>.delayed(const Duration(seconds: 1), () async {
      var tasks = await DatabaseHelper.instance.getTasksByUser(user.id);
      user.tasks = tasks;
      return tasks;
    });

class _CreateTasksState extends State<CreateTasks> {
  bool pressed = false;

  final nameController = TextEditingController();
  final datetimeController = TextEditingController();
  final descriptionController = TextEditingController();
  final userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;

    Future<List<Task>> tasks = getTasks(currentUser);
    return FutureBuilder<List<Task>>(
      future: tasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
          children: [Column(
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
                children:
                    currentUser.tasks.map((task) => taskCard(task)).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  pressed ? const CreateTasksForm() : const SizedBox(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFF29765),
                      textStyle: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                    child: pressed
                        ? const Text("Go Back")
                        : const Text("Add Task"),
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
        ]
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
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
  DateTime year = new DateTime(DateTime.now().year);

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
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: datetimeController,
              validator: datetimeValidator.validate,
              decoration: const InputDecoration(
                labelText: 'Date and Time',
              ),
            ),
          ),
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
          DateTimePicker(
            type: DateTimePickerType.date,
            //dateMask: 'yyyy/MM/dd',
            // controller: _controller3,
            //initialValue: _initialValue,
            firstDate: year,
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateLabelText: 'Date',
            locale: Locale('en', 'US'),
            //onChanged: (val) => setState(() => _valueChanged3 = val),
            // validator: (val) {
            //  setState(() => _valueToValidate3 = val ?? '');
            //  return null;
            //  },
            //  onSaved: (val) => setState(() => _valueSaved3 = val ?? ''),
          ),
          DateTimePicker(
            type: DateTimePickerType.time,
            //timePickerEntryModeInput: true,
            //controller: _controller4,
            initialValue: '', //_initialValue,
            icon: Icon(Icons.access_time),
            timeLabelText: "Time",
            use24HourFormat: false,
            locale: Locale('en', 'US'),
            // onChanged: (val) => setState(() => _valueChanged4 = val),
            // validator: (val) {
            //   setState(() => _valueToValidate4 = val ?? '');
            //  return null;
            // },
            //  onSaved: (val) => setState(() => _valueSaved4 = val ?? ''),
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
                Task task = Task(
                  currentUser.taskCount,
                  nameController.text,
                  datetimeController.text,
                  descriptionController.text,
                  currentUser.id,
                );

                addTask(currentUser, task);

                if (_formKey.currentState!.validate()) {
                  await DatabaseHelper.instance.addTask(
                    //I HAVE NO IDEA HOW TO CALL THE FUNCTION FROM THE DATABASE HELPER LOL PLS HELP
                    nameController.text, datetimeController.text,
                    descriptionController.text, currentUser.id,
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
      return 'Please enter a date';
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
