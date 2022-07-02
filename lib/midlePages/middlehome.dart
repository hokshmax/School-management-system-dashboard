import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/firebase.dart';
import 'package:dashboard/interFaces/changeNavi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'StudentsAttendense.dart';

class middleHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return middleHomeState();
  }

}

class middleHomeState extends State<middleHome>{






  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(


        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,

            children: [
              Text("HOME",style: TextStyle(
                color: Colors.orange
                    ,fontSize: 60
              ),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                    height: 100,
                    width: 200,
                    decoration:BoxDecoration (
                  color: Colors.orange
                      ,
                    borderRadius: BorderRadius.circular(20)
                  ),
                child: Align(
                  alignment: Alignment.center,
                  child:
                  InkWell(
                    onTap: (){
                      setState(() {
                        Provider.of<changeNavi>(context, listen:false).change(101);

                      });                    },
                    child: Text("Students Attendense ",style: TextStyle(
                        fontSize: 20
                        ,

                        color: Colors.blue
                    )


                    ) ,
                  ),
                )

                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      Provider.of<changeNavi>(context, listen:false).change(10);

                    });

                  },
                  child: Container(
                      height: 100,
                      width: 200,
                      margin: EdgeInsets.all(20),

                      decoration:BoxDecoration (
                          color: Colors.orange
                          ,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:  Align(
                          alignment: Alignment.center,

                          child: Text("Students",style: TextStyle(
                              fontSize: 20
                              ,
                              color: Colors.blue
                          ),
                          )


                      )
                  ) ,
                )


              ],

            ),


               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child:  Container(
                          margin: EdgeInsets.all(20),

                          height: 100,
                          width: 200,

                          decoration:BoxDecoration (
                              color: Colors.orange
                              ,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Align(
                              alignment: Alignment.center,

                              child: Text("Driver Account",style: TextStyle(
                                  fontSize: 20
                                  ,
                                  color: Colors.blue
                              ),
                              )


                          )
                      ),
                      onTap:() {
                        setState(() {
                          Provider.of<changeNavi>(context, listen: false).change(11);
                        });
                      },
                    )
                   ,
                    InkWell(
    onTap:(() {
    setState(() {
    Provider.of<changeNavi>(context, listen: false).change(12);
    });}),
    child: Container(
                          margin: EdgeInsets.all(20),

                          height: 100,
                          width: 200,

                          decoration:BoxDecoration (
                              color: Colors.orange
                              ,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:Align(
                              alignment: Alignment.center,
                              child: Text("Partner Account ",style: TextStyle(
                                  fontSize: 20
                                  ,
                                  color: Colors.blue
                              ),
                              )


                          )
                      ) ,
                    )

                  ],

                ) ,







            ]
        )
    );

  }

}