import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';

class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RemindersState();

}

class RemindersState extends State<Reminders> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;
    return ListView(
      children: [Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("Reminders Page!"),
        ],
      ),
    ]
    );
  }

}