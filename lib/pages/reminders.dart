import 'package:flutter/material.dart';

class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RemindersState();

}

class RemindersState extends State<Reminders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Achievements"),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("Reminders Page!"),
        ],
      ),
    );
  }

}