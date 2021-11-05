import 'package:flutter/material.dart';
import 'package:my_app/pages/tasks.dart';
import 'package:my_app/pages/reminders.dart';
import 'package:my_app/pages/timer.dart';
import 'package:my_app/pages/achievements.dart';
import 'package:my_app/pages/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

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
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: tabController,
          children: const <Widget>[
            Tasks(),
            Reminders(),
            Timer(),
            Achievements(),
            Settings(),
          ]
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

