import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/user.dart';
import '../models/task.dart';
import '../pages/createTasks.dart';
import '../pages/reminders.dart';
import '../pages/timer.dart';
import '../pages/achievements.dart';
import '../pages/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
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
      )
  );
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    final currentUser = ModalRoute.of(context)!.settings.arguments as User;

    const List<Tab> tabs = <Tab>[
      Tab(text: "Tasks"),
      Tab(text: "Reminders"),
      Tab(text: "Timer"),
      Tab(text: "Achievements"),
      Tab(text: "Settings")
    ];
    final tabController = TabController(length: tabs.length, vsync: this);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home",
          style: TextStyle(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF29765),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
          Center(
            child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF29765),
                ),
                child: const Text('Logout',
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }),
          ),
          /*
          Center(
            child:  TabBarView(
              controller: tabController,
              children: const <Widget>[
              CreateTasks(),
              Reminders(),
              Timer(),
              Achievements(),
              Settings(),
            ],),
          ),
*/
        ],
      ),

      bottomNavigationBar: TabBar(
        controller: tabController,
        tabs: tabs,
        labelColor: Colors.blueAccent,
        unselectedLabelColor: Colors.blue,
        indicatorColor: Colors.blue,
     ),
    );
  }
}

