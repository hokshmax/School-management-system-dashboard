import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class markerNavi extends ChangeNotifier  {


  LatLng   marker;


  void change(LatLng index){
    this.marker=index;

    addListener(() {
      this.marker=index;
    });

    notifyListeners();

  }

}