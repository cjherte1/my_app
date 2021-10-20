import 'package:flutter/material.dart';
import  'package:my_app/pages/home_screen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an Account'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(50,150,50,8),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your username'
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your username'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
              Navigator.pushNamed(context,'/home');
              },

              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple
              ),
            ),
          ),
        ],
      ),

    );
  }
}
