import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {


    final currentUser = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome ' + currentUser.firstName + '!',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child:  ElevatedButton(
                child: const Text('Logout'),
                onPressed: () {
                  Navigator.pop(context);
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
    );
  }
}