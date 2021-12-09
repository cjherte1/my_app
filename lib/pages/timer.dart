import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:numberpicker/numberpicker.dart';

import 'NotificationApt.dart';


class TimerPg extends StatefulWidget {
  const TimerPg({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimerPgState();

}

class TimerPgState extends State<TimerPg> {
  int _hour = 0;
  int _minute = 0;
  int _second = 0;
  int _current = 0;
  bool pressedStart = false;
  bool pressedStop = false;
  CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: 0),
      const Duration(seconds: 0),
  );

  void _startTimer() {
    int dur = (_hour*3600)+(_minute*60)+_second+1;
    // Disable the button after it has been pressed
     countDownTimer = CountdownTimer(
      Duration(seconds: dur),
      const Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      if(mounted) {
        setState(() {
          _current = dur - duration.elapsed.inSeconds;
        });
      }
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
      pressedStop = false;
      pressedStart = false;
      NotificationApi.showNotification(
            title: 'Times Up!',
      );
    });
  }

  void _stopTimer() {
    setState(() {
      _current = 0;
    });
    countDownTimer.cancel();
    pressedStop = false;
    pressedStart = false;
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        //TODO: Change all sizedBoxes to correspond with a ratio/ fraction of the screen
        const SizedBox(height: 100),
        //Row of columns
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Hour column
            Column(
              children: <Widget>[
                const Text("Hours",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Visibility(child:
                  NumberPicker(
                    value: _hour,
                    minValue: 0,
                    maxValue: 23,
                    haptics: true,
                    itemHeight: 30.0,
                    selectedTextStyle: const TextStyle(
                        color: Color(0xFFF29765),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    onChanged: (value) => setState(() => _hour = value),
                  ),
                  visible: !pressedStart,
                ),
                Text('Hours: $_hour'),
                const SizedBox(height: 30),
              ],
            ),
            const SizedBox(width: 20),
            //Minute column
            Column(
              children: <Widget>[
                const Text("Minutes",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Visibility(child:
                  NumberPicker(
                    value: _minute,
                    minValue: 0,
                    maxValue: 59,
                    haptics: true,
                    itemHeight: 30.0,
                    selectedTextStyle: const TextStyle(
                        color: Color(0xFFF29765),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    onChanged: (value) => setState(() => _minute = value),
                  ),
                  visible: !pressedStart,
                ),
                Text('Minutes: $_minute'),
                const SizedBox(height: 30),
              ],
            ),
            const SizedBox(width: 20),
            //Second column
            Column(
              children: <Widget>[
                const Text("Seconds",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Visibility(child:
                  NumberPicker(
                    value: _second,
                    minValue: 0,
                    maxValue: 59,
                    haptics: true,
                    itemHeight: 30.0,
                    selectedTextStyle: const TextStyle(
                      color: Color(0xFFF29765),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                    onChanged: (value) => setState(() => _second = value),
                  ),
                  visible: !pressedStart,
                ),
                Text('Seconds: $_second'),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFF29765),
                      textStyle: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pressedStart = !pressedStart;
                    pressedStop = !pressedStop;
                    _startTimer();
                  },
                  child: const Text("Start Timer"),
              ), //Your widget is gone and won't take up space
              visible: !pressedStart,
            ),
            Visibility(
              child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFF29765),
                    textStyle: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  _stopTimer();
                },
                child: const Text("Stop Timer"),
              ), //Your widget is gone and won't take up space
              visible: pressedStart,
            ),
            const SizedBox(height: 10),
            Text("$_current",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

}

