import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
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
        backgroundColor: Colors.blue,
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

