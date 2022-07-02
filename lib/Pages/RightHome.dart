
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/interFaces/changeNavi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../setUPlocation.dart';


class rightHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return rightHomeState();
  }

}


class rightHomeState extends State<rightHome>{


  String loc="";
  String phone="";
  String email="";
  String schoolName="";


  
  
  getSchoolData()
  {
    SharedPreferences.getInstance().then((value1) {
      
      FirebaseFirestore.instance.collection("Admins").doc(value1.get('id')).get().then((value) {

        setState(() {
          email=value.get('email');
          schoolName=value.get('schoolname');
          phone=value.get('phone').toString();
          loc=value.get('address').toString();
        });



      }
        );


    });
    
  }
  
  getloc()
  async {
    LocationData location1=await location().getLocation();



 var ss  =await GeoCode(apiKey: "AIzaSyAy7HT6KYQZK5Ud9-a3VOhxNwq0kGnxKg4").reverseGeocoding(latitude: location1.latitude,longitude: location1.longitude);
setState(() {
  loc=ss.streetAddress;
});

  }


  @override
  void initState() {
    getSchoolData();

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
     width: 300,

     child:SafeArea(child: Stack(
       children: [
         Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
           children: [
             TextButton.icon(onPressed:(){

             },
               label: Text("Log Out"),
               icon: Icon(Icons.arrow_back),),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(schoolName,style: TextStyle(
                     fontSize: 40
                     ,
                     color: Colors.orange
                 ),)
                 ,
                 ImageIcon(
                   AssetImage("icons/businesscard.png"),
                   size: 20,
                 )
               ],
             ),
             InkWell(
               onTap: ()
               {
                 Provider.of<changeNavi>(context, listen:false).change(33);
               },
               child:
             Text("Edit Profile ",style: TextStyle(
                 fontSize: 30
                 ,
                 color: Colors.orange
             ),),)




           ],
         ),
         Align(
           alignment: Alignment.bottomCenter,
           child: Padding(
             padding: EdgeInsets.symmetric(vertical: 200),
             child:  Column(
               mainAxisSize: MainAxisSize.min,
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Text(

                     "School Information",style: TextStyle(
                     fontSize: 30
                     ,
                     color: Colors.blue
                 )
                 ),
                 Row(
                   children:[
                     Icon(
                         Icons.phone
                     ),
                     Text(phone,style: TextStyle(
                         fontSize: 20
                         ,
                         color: Colors.blue
                     ))
                   ],
                 ),
                 Row(
                   children:[
                     Icon(
                         Icons.alternate_email
                     ),
                     Text(email,style: TextStyle(
                         fontSize: 20
                         ,
                         color: Colors.blue
                     ))
                   ],
                 ),   Row(
                   children:[
                     Icon(
                         Icons.location_on
                     ),
                     Text(loc,style: TextStyle(
                         fontSize: 20
                         ,
                         color: Colors.blue
                     ))
                   ],
                 )

               ],
             ),
           ) 
         )

       ],
     ))
   );
  }

}