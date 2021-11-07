import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AchievementsState();

}

class AchievementsState extends State<Achievements> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Achievements"),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("Achievements Page!"),
        ],
      ),
    );
  }

}