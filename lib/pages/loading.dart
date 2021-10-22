import 'package:flutter/material.dart';
import  'package:my_app/pages/home_screen.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context,'/login');
                },
                child: Text('Login'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context,'/createAccount');
                },
                child: Text('Create An Account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}