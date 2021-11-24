import 'package:flutter/material.dart';
import '../models/user.dart';
import '../pages/create_tasks.dart';
import '../pages/reminders.dart';
import '../pages/timer.dart';
import '../pages/achievements.dart';
import '../pages/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
/*
CREATES A CARD WIDGET FOR EACH TASK
just formats the task information into a box
 */

Widget taskCard(task) {
  return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              task.datetime,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              task.name,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ));
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String appBarText = "Tasks";

  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;

    const List<Tab> tabs = <Tab>[
      Tab(text: "Tasks"),
      Tab(text: "Reminders"),
      Tab(text: "Timer"), //, icon: Icon(Icons.timer)
      Tab(text: "Achievements"),
      Tab(text: "Settings") //, icon: Icon(Icons.settings)
    ];
    final tabController = TabController(length: tabs.length, vsync: this);

    //TabBar Animation
    final DecorationTween decorationTween = DecorationTween(
      begin: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFF29765)],
              stops: [0.7, 1.0],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              tileMode: TileMode.repeated )),
      end: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFF29765)],
              stops: [0.8, 1.0],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              tileMode: TileMode.repeated)),
    );
    final animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animationController.repeat(reverse: true);

    return Scaffold(
        appBar: AppBar(
            //StatefulBuilder allows for the AppBar Title to be refreshed
            // without refreshing the whole widget
            title: StatefulBuilder(builder: (titleContext, titleSetState) {
              tabController.addListener(() {
                titleSetState(() {
                  appBarText = tabs.elementAt(tabController.index).text.toString();
                });
              });
              return Text(
                  appBarText,
                  style: const TextStyle(color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold));
            }),
            centerTitle: true,
            backgroundColor: const Color(0xFFF29765),
            automaticallyImplyLeading: false
        ),
        body: Center(
              child: TabBarView(
                  controller: tabController,
                  children: const <Widget>[
                    CreateTasks(),
                    Reminders(),
                    TimerPg(),
                    Achievements(),
                    Settings()])
        ),
        bottomNavigationBar: DecoratedBoxTransition(
          decoration: decorationTween.animate(animationController),
          child: TabBar(
              controller: tabController,
              tabs: tabs,
              labelColor: const Color(0xFFF29765),
              unselectedLabelColor: const Color(0xFFF29765),
              indicator: const BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Colors.white, Colors.blue, Color(0xFFF29765)],
                      stops: [0.69, 0.7, 0.9],
                      center: Alignment(0, -1),
                      radius: 1.4,
                      //focalRadius: 0.0,
                      focal: Alignment(0, -1)))))
    );
  }
}
