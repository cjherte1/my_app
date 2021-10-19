import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Application'),
          centerTitle: true,
        ),
        body: Form(
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextFormField(
                  controller: userController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    await DatabaseHelper.instance.authenticateLogin(
                        userController.text.toLowerCase(), passwordController.text);
                  }),
              ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    DatabaseHelper.instance.addUser(userController.text.toLowerCase(), passwordController.text);

                  }),
              ElevatedButton(
                  child: const Text('Delete User'),
                  onPressed: () {
                    DatabaseHelper.instance.removeUser(userController.text.toLowerCase());

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

/*void main() => runApp(const MaterialApp(
  home: Home()
));


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Application'),
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
                hintText: 'Enter your username',
              ),
            ),
          ),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home2())
                );
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

class Home2 extends StatelessWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Application'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: const Center(
          child: Text(
              'Sign in success',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              )
          ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          },
        child: const Text('Click'),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
*/
