import 'dart:html';

import 'package:dashboard/Pages/middleHome.dart';
import 'package:dashboard/interFaces/changeNavi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'RightHome.dart';

class home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
return homeState();  }

}




class homeState extends State<home>{
  int _selectedIndex=0;

  changeNavi ch =changeNavi();


  @override
  void initState() {
     SharedPreferences.getInstance().then((value1) {
       if (value1.get('id') != FirebaseAuth.instance.currentUser.uid ||
           FirebaseAuth.instance.currentUser == null) {
         Navigator.popAndPushNamed(context, "startPage");
         return;

       }
     });
    super.initState();
    Provider.of<changeNavi>(context, listen:false).change(_selectedIndex);

  }

  Set<String> icons={
    "icons/home.png",
    "icons/bus.png",
    "icons/businesscard.png",
    "icons/carsteering.png",
    "icons/contactbook.png",
    "icons/contactinformation.png",
   "icons/placeholder.png",
    "icons/friends.png"
  };

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [



    LayoutBuilder(builder: (context,con){

      return

        SingleChildScrollView(
         child: Container(

           decoration: BoxDecoration(
             shape: BoxShape.rectangle,
             color: Colors.white
             ,

           ),
           width: MediaQuery.of(context).size.width*(1/4),
           child:          Column(
             mainAxisSize: MainAxisSize.max,
             children: [
              Text ("max",style: TextStyle(
                backgroundColor: Colors.white
              ),),

               ConstrainedBox(constraints:  BoxConstraints(maxWidth: 300,maxHeight: MediaQuery.of(context).size.height
               ),child:IntrinsicHeight(

                   child:
                   NavigationRail(


                     selectedIndex: _selectedIndex,
                     onDestinationSelected: (int index) {

                       setState(() {
                         _selectedIndex=index;
                         Provider.of<changeNavi>(context, listen:false).change(_selectedIndex);

                       });





                     },
                     labelType: NavigationRailLabelType.all,

                     destinations: [

                       NavigationRailDestination(

                         icon:  customRail(selected:0,icons:icons.elementAt(0),lable:"home"),
                         selectedIcon:customRail(selected:1,icons:icons.elementAt(0),lable:"home"),
                         label: Text(""),

                       ),
                       NavigationRailDestination(
                         icon: customRail(selected:0,icons:icons.elementAt(1),lable:"ADD BUS"),
                         selectedIcon: customRail(selected:1,icons:icons.elementAt(1),lable:"ADD BUS"),
                         label: Text(""),

                       ),
                       NavigationRailDestination(
                         icon: customRail(selected:0,icons:icons.elementAt(2),lable:"CREATE DRIVER ACCOUNT"),
                         selectedIcon: customRail(selected:1,icons:icons.elementAt(2),lable:"CREATE DRIVER ACCOUNT"),
                         label: Text(""),

                       ),
                       NavigationRailDestination(
                         icon: customRail(selected:0,icons:icons.elementAt(3),lable:"ADD STUDENT INFORMATION"),
                         selectedIcon: customRail(selected:1,icons:icons.elementAt(3),lable:"ADD STUDENT INFORMATION"),
                         label: Text(""),

                       ),

                       NavigationRailDestination(
                         icon: customRail(selected:0,icons:icons.elementAt(5),lable:"CREATE PARTNER ACCOUNT"),
                         selectedIcon: customRail(selected:1,icons:icons.elementAt(5),lable:"CREATE PARTNER ACCOUNT"),
                         label: Text(""),

                       ),
                       NavigationRailDestination(
                         icon: customRail(selected:0,icons:icons.elementAt(6),lable:"TRACK SCHOOL BUS "),
                         selectedIcon: customRail(selected:1,icons:icons.elementAt(6),lable:"TRACK SCHOOL BUS"),
                         label: Text(""),

                       )

                     ],
                   )

               )
               )
               ,

             ],
           )
           ,

         ),







        )
       ;

    })





          ,





              // This is the main content.







          VerticalDivider(thickness: 1, width: 1),
          midHome(ch),
          rightHome()

        ],
      ),
    );
  }

}

class customRail extends StatelessWidget{
String lable;
String icons;
int selected;

  customRail({this.selected,this.icons,this.lable});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
     height: 20,
     child:ListTile(
       leading: ImageIcon(
         AssetImage(this.icons),
         color: selected==0?Colors.black : Color(0xFF3A5A98),
       ),
       title: Text(lable,style: TextStyle(color:  selected==0?Colors.black : Color(0xFF3A5A98)),),
     ) ,
   ) ;
  }

}