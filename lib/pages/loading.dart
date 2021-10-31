import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Me-Minders',
          style: TextStyle(
          color: const Color(0xFFF29765),
          fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      backgroundColor: const Color(0xFFF29765),
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 40),
              Image.asset(
               'assets/me-minders-orange.jpeg',
               height: 275,
               width: 275,
             ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.pushNamed(context,'/login');
                },
                child: Text('Login',
                  style: TextStyle(
                    color: const Color(0xFFF29765),
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  Navigator.pushNamed(context,'/createAccount');
                },
                child: Text('Create An Account',
                  style: TextStyle(
                    color: const Color(0xFFF29765),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}