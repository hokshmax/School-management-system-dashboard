
import 'dart:io';

import 'package:dashboard/Pages/Rigster.dart';
import 'package:dashboard/Pages/logIn.dart';
import 'package:dashboard/Pages/startPage.dart';
import 'package:dashboard/interFaces/changeNavi.dart';
import 'package:dashboard/interFaces/marker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/home.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
        ChangeNotifierProvider(

        create: (context) => changeNavi(),

  ),
      ChangeNotifierProvider(

        create: (context) => markerNavi(),

      )
    ],child:  MyApp(),));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DashBoard',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes:{
        '/':(context)=>MyHomePage(),
        "home":(context)=>home(),
        "startPage":(context)=>startPage(),
        "Login":(context)=>login(),
        "SignUp":(context)=>regster(),

      }

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loadingggggggggggggggggggggg',
            ),

          ],
        ),
      ),
    );
  }
  @override
  void initState() {

    super.initState();

    SharedPreferences.getInstance().then((value1) {
      if( FirebaseAuth.instance.currentUser == null){
        Navigator.popAndPushNamed(context, "startPage");
      }
      else if(value1.get('id')==null)
      {
        Navigator.popAndPushNamed(context, "startPage");
      }

     else  if (value1.get('id') != FirebaseAuth.instance.currentUser.uid ||
          FirebaseAuth.instance.currentUser == null) {
        Navigator.popAndPushNamed(context, "startPage");

      }
      else{
        Navigator.popAndPushNamed(context, "home");

      }
    });

  }

}
