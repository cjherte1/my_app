import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AchievementsState();

}

class AchievementsState extends State<Achievements> {

  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;
    return ListView(
      children: [Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Achievements for " + currentUser.firstName),
        ],
      ),
    ]
    );
  }

}