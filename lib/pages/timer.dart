import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:numberpicker/numberpicker.dart';


class TimerPg extends StatefulWidget {
  const TimerPg({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimerPgState();

}

class TimerPgState extends State<TimerPg> {
  @override
  int _hour = 0;
  int _minute = 0;
  int _second = 0;
  int _current = 0;

  void _startTimer() {
    // Disable the button after it has been pressed
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: (_hour*3600)+(_minute*60)+_second+1),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = ((_hour*3600)+(_minute*60)+_second+1) - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Timer Page!"),
            SizedBox(height: 30),
            Text("Select number of hours",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            Text('Hours: $_hour'),
            SizedBox(height: 30),
            Text("Select number of minutes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            Text('Minutes: $_minute'),
            SizedBox(height: 30),
            Text("Select number of seconds",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            Text('Seconds: $_second'),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF29765),
                  textStyle: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                _startTimer();
              },
              child: Text("Start Timer"),
            ),
            SizedBox(height: 10),
            Text("$_current",
              style: TextStyle(
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

