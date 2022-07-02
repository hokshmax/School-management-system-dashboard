
import 'package:dashboard/Pages/Rigster.dart';
import 'package:dashboard/Pages/background.dart';
import 'package:dashboard/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return loginstate();  }

}

class loginstate extends State<login> implements refress{
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:     CustomPaint(
        child: Center(

          child:   Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("icons/capture.png",width: 500,height: 300,),

              Text("Log In as School Mangment",style: TextStyle(
                  fontSize: 30
                  ,
                  color: Colors.blue
              )),

              Container(

                width:400,
                height: 200,

                child:    Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:Padding(padding: EdgeInsets.only(left: 30,right: 30,bottom: 30),
                      child:    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("username"),
                          TextField(
                            controller: email,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.none
                                    )
                                )
                            ),
                          )

                          ,
                          Text("password"),
                          TextField(
                            obscureText: true,
                            controller: pass,

                          )
                        ],


                      ) ,

                    )

                ) ,
              ),
              ElevatedButton(onPressed:() async {




                server(this).login(context,email: email.value.text,password: pass.value.text);



              },style: ElevatedButton.styleFrom(
                  primary: Colors.amberAccent,
                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(10)
                  )


              ), child:Padding(
                  child:   Text("Log In",style: TextStyle(fontSize: 15),),padding: EdgeInsets.symmetric(horizontal: 150,vertical: 5)

              )

                ,),
              Text("Forget Password?",style: TextStyle(

              ),)
            ],
          ),

        ),
        painter: back(),
      ),
    );
  }
  @override
  void initState() {
    SharedPreferences.getInstance().then((value1) {
      if (value1.get('id') == FirebaseAuth.instance.currentUser.uid &&
          FirebaseAuth.instance.currentUser != null) {
        Navigator.popAndPushNamed(context, "home");
        return;

      }
    });

    super.initState();
  }
  @override
  void ref() {
    // TODO: implement ref
  }

}