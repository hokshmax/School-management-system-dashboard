

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dashboard/Pages/background.dart';
import 'package:dashboard/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class regster extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return regsterstate();
  }

}

class regsterstate extends State<regster> implements refress{





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

  CountryCode cc=CountryCode();






  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:CustomPaint(
        painter: back(),
        child:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width/2,
                child:    Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Safe ",style: TextStyle(
                          fontSize: 60
                          ,
                          color: Colors.orange
                      ),),
                      Text(" School Bus",
                          style: TextStyle(
                              fontSize: 60
                              ,
                              color: Colors.orange
                          ) )

                    ])
            )
            ,
            Container(
              width: MediaQuery.of(context).size.width/2,
              color: Colors.lightBlueAccent,
              child:   Column(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,


                children: [
                  Text("Create School Mangment",style: TextStyle(fontSize: 30,color: Colors.blue),),

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
                      CountryCodePicker(
                        onChanged: (vv){
setState(() {
  cc=vv;
});

                        },
                        onInit:(vv){


                            cc=vv;
                                                 },
                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')

                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        // optional. Shows only country name and flag when popup is closed.
                        showOnlyCountryWhenClosed: false,
                        // optional. aligns the flag and the Text left
                        alignLeft: false,
                      ),
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
                        .SigUp(email: email.value.text,pass: password.value.text,schoolid: int.parse(schoolid.value.text)
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
                      child:   Text("Create New Account"),padding: EdgeInsets.symmetric(horizontal: 20,)

                  )

                    ,)


                  ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,


                    children: [
                      Text("already have account ?"),

                      Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                      InkWell(onTap: (){

                        Navigator.pushNamed(context, "Login");

                      },

                          child:Text("Log In")))




                    ],
                  )
                ],

              ),
            )





          ],

        ) ,
      )
   ,
    )  ;
  }

  @override
  void ref() {

    setState(() {
      email.text='';
      password.text='';
      username.text='';
      confirmpassword.text='';
      city.text='';
      address.text='';
      region.text='';
      phone.text='';
      schoolname.text='';
      schoolid.text='';




    });
    print("hoksh");


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