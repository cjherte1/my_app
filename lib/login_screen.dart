import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Application'),
          centerTitle: true,
        ),
        body: Form(
          child: Column(
            children: [
              const SizedBox(height: 100),
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
              const SizedBox(height: 50),
              ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    var result = await DatabaseHelper.instance.authenticateLogin(
                        userController.text.toLowerCase(), passwordController.text);
                    if (result) {
                      User currentUser = await DatabaseHelper.instance.getUserByUsername(userController.text.toLowerCase());
                      Navigator.pushNamed(context, '/home', arguments: currentUser);
                    }
                    else {
                      print("Pop up wrong username/password error here.");
                    }

                  }),
              ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    DatabaseHelper.instance.addUser(userController.text.toLowerCase(), passwordController.text);

                  }),
              ElevatedButton(
                  child: const Text('Delete User'),
                  onPressed: () {
                    if (userController.text.toLowerCase() == 'admin'){
                      print('Error pop up to not delete admin');
                    }
                    else {
                      DatabaseHelper.instance.removeUser(
                          userController.text.toLowerCase());
                    }
                  }),
              ElevatedButton(
                  child: const Text('Clear DB'),
                  onPressed: () {
                    DatabaseHelper.instance.clearDb();

                  }),
              ElevatedButton(
                  child: const Text('Delete DB'),
                  onPressed: () {
                    DatabaseHelper.instance.deleteDb();

                  }),
            ],
          ),
        ),
      ),
    );
  }
}