import 'package:flutter/material.dart';
import '../models/user.dart';
import '../database_helper.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsState();

}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
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
    );
  }

}