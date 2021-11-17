import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/user.dart';
import '../models/task.dart';
import '../pages/create_tasks.dart';
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
      ));
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
        title: const Text(
          "Home",
          style: TextStyle(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF29765),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: TabBarView(
          controller: tabController,
          children: const <Widget>[
            CreateTasks(),
            Reminders(),
            Timer(),
            Achievements(),
            Settings(),
          ],
        ),
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
