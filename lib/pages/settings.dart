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

    return Center(
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF29765),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF29765),
                ),
                child: const Text(
                  'Delete My Account',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (currentUser.username == 'admin') {
                    print('Error pop up to not delete admin');
                  } else {
                    DatabaseHelper.instance.removeUser(currentUser.username);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
