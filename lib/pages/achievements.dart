import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'dart:math';

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AchievementsState();
}

class AchievementsState extends State<Achievements> {
  @override
  Widget build(BuildContext context) {
    final _random = Random();
    final currentUser = ModalRoute.of(context)!.settings.arguments as User;
    var quotes = [
      '"When you have a dream, you’ve got to grab it and never let go. " - Carol Burnett',
      '"Nothing is impossible. The word itself says "I’m possible!" - Audrey Hepburn',
      '"There is nothing impossible to they who will try." - Alexander the Great',
      '"The bad news is time flies. The good news is you’re the pilot." - Michael Altshuler',
      '"Life has got all those twists and turns. You’ve got to hold on tight and off you go." - Nicole Kidman',
      '"Keep your face always toward the sunshine, and shadows will fall behind you." - Walt Whitman',
      '"You define your own life. Don’t let other people write your script." - Oprah Winfrey',
      '"You are never too old to set another goal or to dream a new dream." - Malala Yousafzai',
      '"Spread love everywhere you go." - Mother Teresa',
      '"It is during our darkest moments that we must focus to see the light." - Aristotle',
      '"In a gentle way, you can shake the world." - Mahatma Gandhi',
      '"Be yourself; everyone else is already taken." - Oscar Wilde',
      '"It is never too late to be what you might have been." - George Eliot',
      '"Do what you can, with what you have, where you are." - Theodore Roosevelt',
      '"Success is not final, failure is not fatal: it is the courage to continue that counts." - Winston S. Churchill',
      '"Whatever you are, be a good one." - Abraham Lincoln',
    ];
    var r = _random.nextInt(quotes.length - 1 - 0);

    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/trophy.png"),

          ),

        ),
        child:

      Column(
          children: <Widget>[
            const SizedBox(height: 30),
            Center(
              child: Text('You have finished ' + currentUser.points.toString() + ' task(s)!'
                  '\nYou have ' + (currentUser.points*5).toString() + ' points.',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 475),
            Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(quotes[r],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
            ),

      ]),
    );
  }
}
