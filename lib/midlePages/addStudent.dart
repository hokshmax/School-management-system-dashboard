import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dashboard/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addStudent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addStudentState();  }

}

class addStudentState extends State<addStudent>{

  TextEditingController nationalId=new TextEditingController();
  TextEditingController studentName=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  TextEditingController classNumber=new TextEditingController();
  TextEditingController parentID=new TextEditingController();
  TextEditingController schoolId=new TextEditingController();
  TextEditingController BusId=new TextEditingController();

String Code;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(


        child: Column(


            children: [
              Text("Add Student "),

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
                  controller: studentName,

                  decoration: InputDecoration(

                      hintText: "student NAME",
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


                child:
                Row(
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
                    Flexible(child:  TextField(
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
                  controller: classNumber,
                  decoration: InputDecoration(


                      hintText: "classNumber",
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
                  controller: schoolId,
                  decoration: InputDecoration(


                      hintText: "schoolId",
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
                  controller: BusId,
                  decoration: InputDecoration(


                      hintText: "BusId",
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
                child:  TextField(
                  controller: parentID,
                  decoration: InputDecoration(


                      hintText: "Parent National Uid",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid
                          )
                      )
                  ),
                ),

              ),


              ElevatedButton(onPressed: () {
                server(null).createStudent(nationalId: nationalId.value.text
                    ,studentName: studentName.value.text,phone: phone.value.text,classNumber:classNumber.value.text,
                    parentID:parentID.value.text, schoolId:schoolId.value.text,busId:BusId.value.text);

              }, child: Text(
                  "Add"
              ),

              ),
              Divider(thickness: 1,color: Colors.black,),


              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Students").doc(FirebaseAuth.instance.currentUser.uid).collection(FirebaseAuth.instance.currentUser.uid).snapshots(),
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

                                Text(snap.data.docs.elementAt(index).data()['"nationalId"'].toString())

                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text("studentName"),
                                Text(snap.data.docs.elementAt(index).data()['studentName'].toString())

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
                                Text("classNumber"),
                                Text(snap.data.docs.elementAt(index).data()['classNumber'].toString())

                              ],
                            )
                            ,
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text("parentID"),
                                Text(snap.data.docs.elementAt(index).data()["parentID"].toString())

                              ],
                            )
                            ,
                            Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Text("schoolId"),
                                Text(snap.data.docs.elementAt(index).data()["schoolId"].toString())

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