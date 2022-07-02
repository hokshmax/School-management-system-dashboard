  import 'package:flutter/cupertino.dart';

class changeNavi extends ChangeNotifier  {


  int   index;


  void change(int index){
    this.index=index;

    addListener(() {
      this.index=index;
    });

    notifyListeners();

  }

}