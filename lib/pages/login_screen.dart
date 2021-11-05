import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/user.dart';


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
    return Scaffold(
        appBar: AppBar(
          title:
          const Text('Login',
              style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFF29765),
        ),
        body:  const LoginForm(),

      );

  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: userController,
              validator: UsernameValidator.validate,
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
              validator: PasswordValidator.validate,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF29765),
              ),
              child: const Text('Login',
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {

                if (_formKey.currentState!.validate()) {
                  var result = await DatabaseHelper.instance.authenticateLogin(
                      userController.text.toLowerCase(),
                      passwordController.text);
                  if (result) {
                    User currentUser = await DatabaseHelper.instance
                        .getUserByUsername(userController.text.toLowerCase());
                    Navigator.pushNamed(
                        context, '/home', arguments: currentUser);
                  }
                  else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              "Error: Incorrect username or password. Please try again."),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              }),


          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF29765),
              ),
              child: const Text('Clear DB',
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                DatabaseHelper.instance.clearDb();

              }),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF29765),
              ),
              child: const Text('Delete DB',
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                DatabaseHelper.instance.deleteDb();

              }),
        ],
      ),
    );
  }
}

class UsernameValidator{
  static String? validate(String? value){
    if (value == null || value.isEmpty){
      return 'Please enter a username';
    }
    else{
      return null;
    }
  }
}

class PasswordValidator{
  static String? validate(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    else{
      return null;
    }
  }
}