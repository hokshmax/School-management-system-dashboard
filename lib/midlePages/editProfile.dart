

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/Pages/background.dart';
import 'package:dashboard/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class edit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return editstate();
  }

}

class editstate extends State<edit> implements refress{





  TextEditingController schoolid=new TextEditingController();
  TextEditingController schoolname=new TextEditingController();
  TextEditingController username=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController confirmpassword=new TextEditingController();
  TextEditingController city=new TextEditingController();
  TextEditingController address=new TextEditingController();
  TextEditingController region=new TextEditingController();
  TextEditingController phone=new TextEditingController();






  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child:
            Container(
              height: MediaQuery.of(context).size.height*(3/4),
              width: MediaQuery.of(context).size.width/2,
              color: Colors.lightBlueAccent,
              child:   Column(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,


                children: [
                  Text("Update School Mangment",style: TextStyle(fontSize: 30,color: Colors.blue),),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomView(lable: "School Id",controller:schoolid ,type: 0,),
                      CustomView(lable: "School Name",controller:schoolname ,)
                      ,

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      CustomView(lable: "Username",controller:username ,type: 1,),
                      CustomView(lable: "E-mail",controller:email ,)
                      ,

                    ],
                  )
                  ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      CustomView(lable: "Password",controller:password ,type: 1,),
                      CustomView(lable: "Confirm Password",controller:confirmpassword ,type: 1,),



                    ],
                  )


                  ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      CustomView(lable: "Region",controller:region ,type: 1,),
                      CustomView(lable: "City",controller:city ,type: 1,),



                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      CustomView(lable: "Phone",controller:phone ,type: 0,),
                      CustomView(lable: "Address",controller:address ,type: 1,),



                    ],
                  ),
                  ElevatedButton(onPressed:() async {
                    if(confirmpassword.value.text!=password.value.text)
                    {

                      Fluttertoast.showToast(
                          msg: "password not match",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                      return;
                    }


                    server(this)
                        .updateAccount(email: email.value.text,pass: password.value.text,schoolid: int.parse(schoolid.value.text)
                        ,schoolname: schoolname.value.text,username: username.value.text,
                        city: city.value.text,
                        regin: region.value.text,address: address.value.text,
                        phone:int.parse( phone.value.text));




                  },style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(10)
                      )


                  ), child:Padding(
                      child:   Text("UPDATE"),padding: EdgeInsets.symmetric(horizontal: 20,)

                  )

                    ,)


                  ,

                ],

              ),
            )






        ) ;
  }

  Future<void> ref() async {


    await  SharedPreferences.getInstance().then((value1) {
        FirebaseFirestore.instance.collection("Admins")
            .doc(value1.get('id'))
            .get()
            .then((value) {
              setState(() {
                email.text = value.get('email').toString();
                schoolname.text = value.get('schoolname').toString();
                phone.text = value.get('phone').toString();
                address.text = value.get('address').toString();
                schoolid.text=value.get('schoolid').toString();
                password.text = value.get('password').toString();
                username.text = value.get('username').toString();
                confirmpassword.text = value.get('password').toString();
                city.text = value.get('city').toString();
                region.text = value.get('region').toString();
              });

        }
        );
      });

        }



  @override
  void initState() {

    ref();

    super.initState();



  }
}

class CustomView extends StatelessWidget{
  String lable;
  TextEditingController controller;
  int type;


  CustomView({this.lable,this.controller,this.type});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(this.type==0)
    {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(lable),

          Container(

            width: 200,
            child:

            TextField(
              inputFormatters:               [    FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(

                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )

                  )
              ),
              controller: controller,
            ),
          )

        ],
      );
    }
    else{
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(lable),

          Container(

            width: 200,
            child:

            TextField(

              decoration: InputDecoration(

                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white
                      )

                  )
              ),
              controller: controller,
            ),
          )

        ],
      );
    }

  }


}