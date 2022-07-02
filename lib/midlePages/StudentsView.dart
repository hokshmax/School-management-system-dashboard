import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentsView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return StudentsViewState();
  }

}

class StudentsViewState extends State<StudentsView>{
  @override
  void initState() {
    getId();

    super.initState();
  }

  String id;
  void getId()
  {

    SharedPreferences.getInstance().then((value1)  {


        id= value1.get("id");




    });
  }
  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return    StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Students").where("schoolUid",isEqualTo: id).snapshots(),
        builder:  (BuildContext context,AsyncSnapshot<QuerySnapshot> snap){

          if(!snap.hasData)
          {
            return Center(
              child: CircularProgressIndicator(),
            );                }

          return Flexible(

              child: Column(
                mainAxisSize: MainAxisSize.max,
            children: [

             Flexible(child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text("studentName"),
                 Text("phone"), Text("parentNID"),
                 Text("nationalId"), Text("busId"),Text("classNumber"),




               ],
             )),
              Flexible(child:   ListView.builder(
                itemCount: snap.data.size,

                itemBuilder: (BuildContext context, int index) {

                  return
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [

                    Text(snap.data.docs.elementAt(index).data()['studentName'].toString())
,

                        Text(snap.data.docs.elementAt(index).data()['phone'].toString()),
                  Text(snap.data.docs.elementAt(index).data()["parentNID"].toString()),


                  Text(snap.data.docs.elementAt(index).data()["nationalId"].toString())

                        ,
                        Text(snap.data.docs.elementAt(index).data()['busId'].toString())


                        ,
                        Text(snap.data.docs.elementAt(index).data()["classNumber"].toString())


                      ],
                    ) ,
                  );








                },))


            ],

          ));





        },
      ) ;
  }

}

