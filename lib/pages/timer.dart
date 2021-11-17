import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimerState();

}

class TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("Timer Page!"),
        ],
      ),
    ]
    );
  }

}