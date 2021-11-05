import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/pages/loading.dart';
import 'package:my_app/pages/login_screen.dart';

void main(){


  Widget testWidget;

  testWidgets('Loading Screen Layout Test', (WidgetTester tester) async{

    testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: Loading())
    );

      await tester.pumpWidget(testWidget);

      expect(find.text('Me-Minders'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Create An Account'), findsOneWidget);

  });




  testWidgets('Login Screen Layout Test', (WidgetTester tester) async{

    testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: LoginScreen())
    );

    await tester.pumpWidget(testWidget);

    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

  });
}