import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/interFaces/marker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class mapTrack extends StatefulWidget{
  int index;
  String partnerID;
  mapTrack({this.partnerID});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mapTrackState(partnerID: this.partnerID);
  }

}

class mapTrackState extends State<mapTrack>{
  int index;
  String partnerID;
  TextEditingController getText=TextEditingController();
  ScrollController scrollController=ScrollController();

  mapTrackState({this.partnerID});

  String ChatWith="";

  void getChatInfo()
  {


      setState(() {
        ChatWith=this.partnerID;
      });
    }



  @override
  void initState() {
    getChatInfo();
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  Marker marker=Marker(markerId: MarkerId(
    "1"
  ),position:  LatLng(37.42796133580664, -122.085749655962));
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Future<void> _goToTheLake(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target:latLng ,zoom: 14.4746)
    ));




  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:  AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  CircleAvatar(
                    backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Kriss Benwat",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        body:
        SafeArea(child:   StreamBuilder(
            builder:(context,AsyncSnapshot<DocumentSnapshot> snap){
Provider.of<markerNavi>(this.context, listen:true).change(LatLng(snap.data['latitude'], snap.data['longitude']));
          return Container(

            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: Provider.of<markerNavi>(context, listen:true).marker,
                zoom: 14.4746,
              ),
              markers: {

                Marker(
                  position:   Provider.of<markerNavi>(context, listen:true).marker, markerId: MarkerId("1")
                  )



            },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ) ;

        },
            stream: FirebaseFirestore.instance.collection("location").doc(ChatWith).snapshots()

    )
        )


    );
  }

void xx()
{

}


}