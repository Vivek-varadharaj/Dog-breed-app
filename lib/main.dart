
import 'package:dog_breed_app/screens/home_screen.dart';
import 'package:flutter/material.dart';



void main() async {
   WidgetsFlutterBinding.ensureInitialized();
 
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dog breed app',
      home: HomeScreen(),
    );
  }
}


