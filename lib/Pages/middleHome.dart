import 'dart:convert';
import 'dart:html';

import 'package:dashboard/interFaces/changeNavi.dart';
import 'package:dashboard/midlePages/StudentsAttendense.dart';
import 'package:dashboard/midlePages/StudentsView.dart';
import 'package:dashboard/midlePages/addBusPage.dart';
import 'package:dashboard/midlePages/addStudent.dart';
import 'package:dashboard/midlePages/createDriverAcount.dart';
import 'package:dashboard/midlePages/createPartnerAccount.dart';
import 'package:dashboard/midlePages/driverView.dart';
import 'package:dashboard/midlePages/editProfile.dart';
import 'package:dashboard/midlePages/middlehome.dart';
import 'package:dashboard/midlePages/perantsView.dart';
import 'package:dashboard/midlePages/trackView.dart';
import 'package:floatingpanel/floatingpanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'dart:html';


class midHome extends StatefulWidget {

changeNavi ch;
  midHome(this.ch);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return midHomeState(this.ch);
  }



}

class midHomeState extends State<midHome>{

  changeNavi ch;

  midHomeState(this.ch);

void xx()
{


}


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white
        ),
        width: MediaQuery.of(context).size.width*(2/4),

        child: Column(
          mainAxisSize: MainAxisSize.max,

          children: [
            Container
              (
              margin: EdgeInsets.only(top: 20),
              width:  MediaQuery.of(context).size.width*(1/4),
              child:



              TextField(

                decoration: InputDecoration(
                    prefixIcon:Icon(Icons.search),

                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            style: BorderStyle.solid
                        )
                    )
                ),
              ),
            ),




            Consumer<changeNavi>(
                builder: (context,c,child){

                  print("hoksh${c.index}");

                  return _status(c.index);
                }


            )

            //  _status(0)



          ],
        ),
      )

    ;
  }
  Widget _status(status) {

    switch(status)
    {
      case 0:
        return middleHome();

      case 1: return addBus();
      case 2:return createDriverAccount();
      case 3:return addStudent();

      case 4:return createPartnerAccount();

      case 5:return trackView();


      case 10:return StudentsView();
      case 11:return driverView();
      case 12:return PerantsView();
      case 33:return edit();
      case 101:return StudentsattendenseView();



    }
    }
  }


