import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_search/screens/myHomePage.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Computer Repair',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        primarySwatch: Colors.blue, 
        visualDensity: VisualDensity.adaptivePlatformDensity, 
      ),
      home: MyHomePage(title: 'Computer Repair Home Page'),
      debugShowCheckedModeBanner: false, 
    );
  }
}
