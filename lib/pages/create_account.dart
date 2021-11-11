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
      body: const CreateAccountForm(),
    );
  }
}

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({Key? key}) : super(key: key);

  @override
  CreateAccountFormState createState() {
    return CreateAccountFormState();
  }
}

class CreateAccountFormState extends State<CreateAccountForm> {

  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: ListView(
        children: [Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: firstNameController,
              validator: FirstNameValidator.validate,
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
              validator: LastNameValidator.validate,
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
              validator: CreateUsernameValidator.validate,
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
              validator: CreatePasswordValidator.validate,
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

                User user = User(getUserTotal(),firstNameController.text, lastNameController.text,
                  userController.text.toLowerCase(), passwordController.text);

                addUser(user);

                if (_formKey.currentState!.validate()) {
                  var success = await DatabaseHelper.instance.addUser(
                    firstNameController.text, lastNameController.text,
                    userController.text.toLowerCase(), passwordController.text,
                  );

                  if (success) {
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
                        title: const Text(
                            "Error: Username already taken."),
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
                }

          ),
        ],
      ),
    ],
      ),
    );
  }
}

class FirstNameValidator{
  static String? validate(String? value){
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;

  }
}

class LastNameValidator{
  static String? validate(String? value){
    if (value == null || value.isEmpty){
      return 'Please enter your last name';
    }
    else{
      return null;
    }
  }
}

class CreateUsernameValidator{
  static String? validate(String? value){
    if (value == null || value.length < 3) {
      return 'Username needs at least 3 characters';
    }
    return null;
  }
}

class CreatePasswordValidator{
  static String? validate(String? value){
    RegExp regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (value == null || value.isEmpty) {
      return 'Enter a password';
    }
    else if (!regExp.hasMatch(value)){
      return 'Minimum 8 characters, one letter and one number';
    }
    return null;
  }
}
