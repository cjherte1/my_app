import 'package:flutter/material.dart';
import '../models/user.dart';
import '../database_helper.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an Account',
          style: TextStyle(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF29765),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF29765),
              ),
              child: const Text('Create Account',
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                  var success = await DatabaseHelper.instance.addUser(
                    firstNameController.text, lastNameController.text,
                    userController.text.toLowerCase(), passwordController.text,
                  );
                  if (success){
                    User currentUser = await DatabaseHelper.instance.getUserByUsername(userController.text.toLowerCase());
                    Navigator.pushNamed(context, '/home', arguments: currentUser);
                  }
                }
              ),
        ],
      ),

    );
  }
}
