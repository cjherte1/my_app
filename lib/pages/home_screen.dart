import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

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
        title: const Text("Home"),
        //centerTitle: true,
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
                child: const Text('Logout'),
                onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                }),
          ),
          Center(
            child:  ElevatedButton(
                child: const Text('Delete My Account'),
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

