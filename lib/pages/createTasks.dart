import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/task.dart';
import '../database_helper.dart';


class CreateTasks extends StatefulWidget {
  const CreateTasks({Key? key}) : super(key: key);

  @override
  State<CreateTasks> createState() => _CreateTasksState();
}

class _CreateTasksState extends State<CreateTasks> {


  final nameController = TextEditingController();
  final datetimeController = TextEditingController();
  final descriptionController = TextEditingController();
  final userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task',
          style: TextStyle(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF29765),
      ),
      body: const CreateTasksForm(),
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
                labelText: 'task Name',
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

          SizedBox(height: 30),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF29765),
              ),
              child: const Text('Create task',
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {

                if (_formKey.currentState!.validate()) {
                  DatabaseHelper.instance.addTask( //I HAVE NO IDEA HOW TO CALL THE FUNCTION FROM THE DATABASE HELPER LOL PLS HELP
                    nameController.text, datetimeController.text,
                    descriptionController.text, currentUser.id,
                  );
                }
              }

          ),
        ],
      ),
    );
  }
}

class nameValidator{
  static String? validate(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter a task name';
    }
    return null;

  }
}
//TO DO: validate date and time in correct format.
class datetimeValidator{
  static String? validate(String? value){
    if (value == null || value.isEmpty){
      return 'Please enter a date';
    }
    else{
      return null;
    }
  }
}

class descriptionValidator{
  static String? validate(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }
}

