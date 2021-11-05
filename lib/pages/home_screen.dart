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
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
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
          Center(
            child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF29765),
                ),
                child: const Text('Delete My Account',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ),
                ),
                onPressed: () {
                  if (currentUser.username == 'admin'){
                    print('Error pop up to not delete admin');
                  }
                  else {
                    DatabaseHelper.instance.removeUser(
                        currentUser.username);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }
                }),
          ),
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

