import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentsattendenseView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudentsattendenseViewState();
  }

}

class StudentsattendenseViewState extends State<StudentsattendenseView>{
  
  List<DocumentSnapshot>students=[];
  @override
  void initState() {
    super.initState();
    getId();

  }
  String id;
  int index=null;
  void getId()
  {

    SharedPreferences.getInstance().then((value1)  {
setState(() {
  id= value1.get("id");

});





    });
  }

  getfristIndex(AsyncSnapshot<QuerySnapshot> snap)
  {

    snap.data.docs.elementAt(0).data().map((key, value) {

      FirebaseFirestore.instance.collection("Students").doc(key).get().then((value) {
        setState(() {
          this.index=0;

          students.add(value);

        });
      });



    });
  }

  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return    StreamBuilder(
      stream: FirebaseFirestore.instance.collection("studentsAttend").doc(id).collection(id).snapshots(),
      builder:  (BuildContext context,AsyncSnapshot<QuerySnapshot> snap) {



        if (!snap.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }




   if(snap.data.docs.isEmpty)
    {
      return Center(
        child: Text(
          "not Data Recorded"

        ),
      );
    }
   else{
     if(index==null)
     {
       getfristIndex(snap);

     }
   }


          return Flexible(child:   Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                    height: 20,

                    child: ListView.builder(itemCount:  snap.data.size,itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          students.clear();
                          setState(() {
                            this.index=index;
                          });


                          if(snap.hasData)
                          {
                            snap.data.docs.elementAt(index).data().map((key, value) {

                              FirebaseFirestore.instance.collection("Students").doc(value).get().then((value) {
                                setState(() {

                                  students.add(value);

                                });
                              });



                            });
                          }

                        },
                        child: Text(  snap.data.docs.elementAt(index).id,style: TextStyle(backgroundColor:this.index==index? Colors.red:Colors.blue
                        ),),
                      ) ;
                    },scrollDirection: Axis.vertical,))
                ,
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
                  itemCount:  students.length,

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

                            Text(students.elementAt(index).data()['studentName'].toString())
                            ,

                            Text(students.elementAt(index).data()['phone'].toString()),
                            Text(students.elementAt(index).data()["parentNID"].toString()),


                            Text(students.elementAt(index).data()["nationalId"].toString())

                            ,
                            Text(students.elementAt(index).data()['busId'].toString())


                            ,
                            Text(students.elementAt(index).data()["classNumber"].toString())


                          ],
                        ) ,
                      );








                  },))



              ]


          ));




      }
    ) ;
  }


}

