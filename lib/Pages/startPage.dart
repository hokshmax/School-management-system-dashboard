
import 'dart:html';

import 'package:dashboard/Pages/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class startPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return startPageState();
  }

}

class startPageState extends State<startPage>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body:
    CustomPaint(child:   Center(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [

              Column(
                children: [

                  Text("Safe ",style: TextStyle(
                      fontSize: 80
                      ,
                      color: Colors.orange
                  ),),
                  Text(" School Bus",
                      style: TextStyle(
                          fontSize: 80
                          ,
                          color: Colors.orange
                      ) )
                ],
              ),
      Padding(padding:EdgeInsets.symmetric(horizontal: 70) ,
        child:       Image.asset("icons/capture.png",width: 800,height: 300,),


      )


            ],
          )
          ,

          Container(
            height: 85,
            width: 998,

            child:   Card(

                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(93)

                ),
                child:Padding(padding: EdgeInsets.symmetric(horizontal: 60,vertical: 5),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Text("LOG IN AS SCHOOL MANGMENT",style: TextStyle(
                          color: Colors.blue,
                          fontSize: 50
                      ),),

                      ElevatedButton(

                        onPressed:(){

                        Navigator.pushNamed(context, "Login");

                      },style: ElevatedButton.styleFrom(
                          primary: Colors.amberAccent,
                          shape: RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(50)
                          )

                      ), child:Padding(
                          child:   Text("Log In"),padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15)

                      )

                        ,)

                    ],
                  ),

                )

            ),
          )







          ,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [

              Column(
                children: [
                  ElevatedButton(onPressed:(){
                    Navigator.pushNamed(context, "SignUp");

                  },style: ElevatedButton.styleFrom(
                      primary: Colors.amberAccent,
                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(40)
                      )

                  ), child:Padding(
                      child:   Text("Sign Up"),padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15)

                  )

                    ,),
                  Text("Sign UP For School Mangment",style: TextStyle(fontSize: 20),)
                ],
              )


            ],
          )


        ],


      )
      ,

    ),painter: back(),),

    );
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((value1) {
      if (value1.get('id') == FirebaseAuth.instance.currentUser.uid ) {
        Navigator.popAndPushNamed(context, "home");
        return;

      }
    });
    super.initState();
  }
}