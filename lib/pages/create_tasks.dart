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
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final datetimeController = TextEditingController();
  final descriptionController = TextEditingController();
  final userIdController = TextEditingController();
  DateTime year = DateTime(DateTime.now().year);
  bool pressed = false;

  /*
  CREATES A CARD WIDGET FOR EACH TASK
  just formats the task information into a box
  */
  Widget taskCard(User currentUser, List<Task> currentTasks, int index) {
    DateTime dt = DateTime.parse(currentTasks[index].datetime);
    String formattedDate =
        DateFormat('MMMM d, yyyy - h:mm a').format(dt).toString();

    //enum PopupEnum = {complete, delete};
    //PopupMenuItemBuilder itemBuilder = List<PopupMenuEntry> Function(BuildContext context);

    return Dismissible(
        background: const Card(
          color: Colors.red,
          margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        ),
        // secondaryBackground:
        // Container(
        //   color: Colors.yellow,
        //   child: const Text("Deleted!")),
        key: UniqueKey(),
        onDismissed: (direction) {
          Task t = currentTasks[index];
          setState(() {
            currentTasks.removeAt(index);
          });
          currentUser.tasks.remove(t);
          DatabaseHelper.instance.removeTask(t.id);
        },
        child: Card(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(currentTasks[index].name,
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.grey[800])),
                              const SizedBox(height: 6.0),
                              Text(currentTasks[index].description),
                              const SizedBox(height: 6.0),
                              Text(formattedDate,
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey[600])),
                            ]),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              color: const Color(0xFFF29765),
                              onPressed: () {
                                Task t = currentTasks[index];
                                setState(() {
                                  currentTasks.removeAt(index);
                                });
                                DatabaseHelper.instance.completeTask(t.id);
                                currentUser.points += 1;
                                currentUser.completedTasks
                                    .add(currentUser.tasks[index]);
                              },
                              icon: const Icon(Icons.check))
                        ],
                      )
                    ]))));
  }

  Widget createTaskForm() {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;
    return Card(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  FloatingActionButton(
                      backgroundColor: const Color(0xFFF29765),
                      child: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          //Clear fields
                          nameController.text = '';
                          descriptionController.text = '';
                          datetimeController.text = '';

                          pressed = !pressed;
                        });
                      })
                ]),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 50, 0),
                  child: TextFormField(
                    controller: nameController,
                    validator: nameValidator.validate,
                    decoration: const InputDecoration(
                      labelText: 'Task Name',
                      icon: Icon(Icons.create_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 50, 0),
                  child: TextFormField(
                    controller: descriptionController,
                    validator: descriptionValidator.validate,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      icon: Icon(Icons.notes),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 50, 0),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTime,
                    dateMask: 'MMMM d, yyyy - h:mm a',
                    controller: datetimeController,
                    //timePickerEntryModeInput: true,
                    //controller: _controller4,
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Date and Time',
                    use24HourFormat: false,
                    locale: const Locale('en', 'US'),
                    validator: datetimeValidator.validate,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFF29765),
                    ),
                    child: const Text(
                      'Create Task',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseHelper.instance.addTask(
                          nameController.text, datetimeController.text,
                          descriptionController.text, currentUser.id,
                        );
                        currentUser.tasks = await DatabaseHelper.instance
                            .getTasksByUser(currentUser.id);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Successfully added task."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    setState(() {
                                      //Clear fields
                                      nameController.text = '';
                                      descriptionController.text = '';
                                      datetimeController.text = '';

                                      pressed = !pressed;
                                    });
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
            )));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;
    List<Task> currentTasks = currentUser.tasks;

    return Scaffold(
        floatingActionButton: Visibility(
            visible: !pressed,
            child: FloatingActionButton(
                backgroundColor: const Color(0xFFF29765),
                child: const Icon(Icons.playlist_add),
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                })),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Visibility(
              visible: !pressed,
              child: Expanded(
                child: ListView.builder(
                  itemCount: currentUser.tasks.length,
                  itemBuilder: (context, index) {
                    return Column(
                        children: [taskCard(currentUser, currentTasks, index)]);

            /*    Task task = currentTasks[index] as Task;
              DateTime dt = DateTime.parse(task.datetime);
              String formattedDate =
              DateFormat('MMMM d, yyyy - h:mm a').format(dt).toString();
              return Card(

                key: ValueKey(task.name),
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
                        ListTile(
                          contentPadding: EdgeInsets.all(25),
                          title: Text(
                            task.name,
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Icon(Icons.drag_handle),
                          onTap: () {
                            //TODO: OPEN TO EDIT TASK
                          },
                        ),
                        ButtonBar(
                          children: <Widget>[
                            ElevatedButton(
                              child: const Text('Delete'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: () {
                                Task t = currentTasks[index];
                                setState(() {
                                  currentTasks.removeAt(index);
                                });
                                currentUser.tasks.remove(t);
                                DatabaseHelper.instance.removeTask(t.id);
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Complete'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              onPressed: () {
                                Task t = currentTasks[index];
                                setState(() {
                                  currentTasks.removeAt(index);
                                });
                                DatabaseHelper.instance.completeTask(t.id);
                                currentUser.points += 5;
                                currentUser.completedTasks.add(currentUser.tasks[index]);
                              },
                            ),],
                        ),
                      ] ),
                ));
          },

          //TODO: MAKE SURE TASKS GET REORDERED IN DATABASE
          onReorder: (int oldIndex, int newIndex) { setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final Task item = currentTasks.removeAt(oldIndex);

          //DatabaseHelper.instance.removeTask(item.id);
          //currentUser.completedTasks.add(currentUser.tasks[newIndex]);
          currentTasks.insert(newIndex, item);
        });*/
                  },
                ),
              )),
          Visibility(visible: pressed, child: createTaskForm())
        ]));
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
