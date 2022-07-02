import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dashboard/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class createDriverAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return createDriverAccountState();  }

}

class createDriverAccountState extends State<createDriverAccount>{

  TextEditingController busid=new TextEditingController();
  TextEditingController nationalId=new TextEditingController();
  TextEditingController driverName=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController email=new TextEditingController();
  String Code;



  @override
  void initState() {
    super.initState();
    getId();
  }

  String id;
  void getId()
  {

    SharedPreferences.getInstance().then((value1)  {

      setState(() {
        id= value1.get("id");

      });


      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(


        child: Column(


            children: [
              Text("Create Driver AccountState And Assign Bus"),

              Container
                (
                margin: EdgeInsets.all(5),

                width:  MediaQuery.of(context).size.width*(1/5),
                height: 30,
                child: TextField(
                  controller: nationalId,
                  decoration: InputDecoration(

                      hintText: "NATIONAL ID",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid
                          )
                      )
                  ),
                ),
              ),
              Container
                (
                margin: EdgeInsets.all(5),

                width:  MediaQuery.of(context).size.width*(1/5),
                height: 30,

                child: TextField(
                  controller: driverName,

                  decoration: InputDecoration(

                      hintText: "DRIVER NAME",
                      border: OutlineInputBorder(

                          borderSide: BorderSide(

                              style: BorderStyle.solid
                          )
                      )
                  ),
                ),
              ),

              Container
                (
                margin: EdgeInsets.all(5),
                width:  MediaQuery.of(context).size.width*(1/5),
                height: 30,


                child: Row(
                  children: [
                    CountryCodePicker(
                      onChanged: (code){
                        setState(() {
                          Code=code.dialCode;
                        });
                      },                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'IT',
                      favorite: ['+39', 'FR'],
                      countryFilter: ['sa', 'eg'],
                      showFlagDialog: false,
                      comparator: (a, b) => b.name.compareTo(a.name),
                      //Get the country information relevant to the initial selection
                      onInit: (code) =>
                         Code=code.dialCode,
                    ),
                    Flexible(child: TextField(
                      controller: phone,
                      decoration: InputDecoration(


                          hintText: "PHONE",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.solid
                              )
                          )
                      ),
                    ), )

                  ],
                )
              ),
              Container
                (
                margin: EdgeInsets.all(5),
                width:  MediaQuery.of(context).size.width*(1/5),
                height: 30,


                child: TextField(
                  controller: password,
                  decoration: InputDecoration(


                      hintText: "PASSWORD",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid
                          )
                      )
                  ),
                ),
              ),
              Container
                (
                margin: EdgeInsets.all(5),
                width:  MediaQuery.of(context).size.width*(1/5),
                height: 30,


                child: TextField(
                  controller: email,
                  decoration: InputDecoration(


                      hintText: "EMAIL",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid
                          )
                      )
                  ),
                ),

              ),
              Container
                (
                margin: EdgeInsets.all(5),
                width:  MediaQuery.of(context).size.width*(1/5),
                height: 30,


                child: TextField(
                  controller: busid,
                  decoration: InputDecoration(


                      hintText: "Bus Id",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid
                          )
                      )
                  ),
                ),
              ),
              ElevatedButton(onPressed: () {
                server(null).createDriver(nationalId: nationalId.value.text
                    ,driverName: driverName.value.text,phone: Code+phone.value.text,password:password.value.text,
                email:email.value.text,busid:busid.value.text);

              }, child: Text(
                  "Add"
              ),

              ),
              Divider(thickness: 1,color: Colors.black,),


              StreamBuilder(
                stream:  FirebaseFirestore.instance.collection("driverAccount").where("schoolUid",isEqualTo:id ).snapshots(),
                builder:  (BuildContext context,AsyncSnapshot<QuerySnapshot> snap){

                  if(!snap.hasData)
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );                }

                  return SizedBox(
                    width: 500,
                    height: 200,

                    child:       GridView.count(



                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(snap.data.size, (index) {

                        return Column(

                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text("nationalId"),
                                Text(snap.data.docs.elementAt(index).data()["nationalId"].toString())

                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text("driverName"),
                                Text(snap.data.docs.elementAt(index).data()['driverName'].toString())

                              ],
                            )
                            ,
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text("phone"),
                                Text(snap.data.docs.elementAt(index).data()['phone'].toString())

                              ],
                            )
,
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text("email"),
                                Text(snap.data.docs.elementAt(index).data()['email'].toString())

                              ],
                            )
,
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text("password"),
                                Text(snap.data.docs.elementAt(index).data()["password"].toString())

                              ],
                            )
,
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text("Bus Id"),
                                Text(snap.data.docs.elementAt(index).data()["busid"].toString())

                              ],
                            )

                          ],
                        );
                      }),
                    ),
                  );





                },
              )



            ]
        )
    );

  }

}