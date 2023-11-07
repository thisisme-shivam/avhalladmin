
import 'package:avhalladmin/pages/AddNewHall.dart';
import 'package:avhalladmin/pages/BookingPage.dart';
import 'package:avhalladmin/pages/HomePage.dart';
import 'package:avhalladmin/pages/RegisterTeacher.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      home: HomePage(),


      initialRoute: '/',
      routes: {


        '/bookhall': (context) => const BookingPage(),
        '/registerteacher':(context)=> const RegisterTeacher(),
        '/addhall':(context)=>const AddNewHall(),
      },
    );
  }
}
