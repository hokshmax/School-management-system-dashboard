import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/midlePages/chatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerantsView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PerantsViewState();
  }

}

class PerantsViewState extends State<PerantsView>{
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
      stream: FirebaseFirestore.instance.collection("pernatsAccount").where("schoolUid",isEqualTo: id).snapshots(),
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
                    Text("parnterName"),
                    Text("phone"), Text("email"),
                    Text("password"),
                    Text("nationalId"), Text("busId")




                  ],
                )),
                Flexible(child:   ListView.builder(
                  itemCount: snap.data.size,

                  itemBuilder: (BuildContext context, int index) {

                    return
                      InkWell(
                        onTap: (){
                          showBottomSheet(

                              context: context,
                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: chat(index:55,partnerID: snap.data.docs.elementAt(index).id,),
                                )  ;
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.rectangle
                          ),
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            children: [

                              Text(snap.data.docs.elementAt(index).data()['parnterName'].toString())
                              ,

                              Text(snap.data.docs.elementAt(index).data()['phone'].toString()),
                              Text(snap.data.docs.elementAt(index).data()["email"].toString()),

                              Text(snap.data.docs.elementAt(index).data()["password"].toString())
                              ,

                              Text(snap.data.docs.elementAt(index).data()["nationalId"].toString())

                              ,
                              Text(snap.data.docs.elementAt(index).data()['username'].toString())


                              ,


                            ],
                          ) ,
                        ),
                      )
                    ;








                  },))


              ],

            ));





      },
    ) ;
  }

}

