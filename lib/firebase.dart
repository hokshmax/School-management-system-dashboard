

import 'dart:html';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/loginInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class server  {

  refress  ref;
server(this.ref);



  void updateAccount({String email,String pass,int schoolid,String schoolname,String username,String confirmpass,String regin,String city,int phone,String address})
  {

    SharedPreferences.getInstance().then((value1) {

      if(FirebaseAuth.instance.currentUser.uid!= value1.get('id'))
        {

          FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).then((value1) {

            value1.user.updatePassword(pass).then((valu1) {

              FirebaseFirestore.instance.collection("Admins").doc(value1.user.uid).update({"id":value1.user.uid,"username":username,"password":pass,"email":email,"schoolid":schoolid
                ,"schoolname":schoolname,"region":regin,"city":city,"address":address,
                "phone":phone});
              Fluttertoast.showToast(
                  msg:"Updated Scs",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            });
            });

        }
      else{

        FirebaseAuth.instance.currentUser.updatePassword(pass).then((value) {
          FirebaseFirestore.instance.collection("Admins").doc(FirebaseAuth.instance.currentUser.uid).update({"id":FirebaseAuth.instance.currentUser.uid,"username":username,"password":pass,"email":email,"schoolid":schoolid
            ,"schoolname":schoolname,"region":regin,"city":city,"address":address,
            "phone":phone});

        });

      }




    });



      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass).then((value) {

      FirebaseFirestore.instance.collection("Admins").doc(value.user.uid).set({"id":value.user.uid,"username":username,"password":pass,"email":email,"schoolid":schoolid
        ,"schoolname":schoolname,"region":regin,"city":city,"address":address,
        "phone":phone});
      this.ref.ref();

    },onError: ( err){


      Fluttertoast.showToast(
          msg:( err as FirebaseAuthException).message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(err.message);
    });

  }


  void SigUp({String email,String pass,int schoolid,String schoolname,String username,String confirmpass,String regin,String city,int phone,String address})
  {


    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass).then((value) {
      
      FirebaseFirestore.instance.collection("Admins").doc(value.user.uid).set({"id":value.user.uid,"username":username,"password":pass,"email":email,"schoolid":schoolid
      ,"schoolname":schoolname,"region":regin,"city":city,"address":address,
        "phone":phone});
this.ref.ref();

    },onError: ( err){


      Fluttertoast.showToast(
          msg:( err as FirebaseAuthException).message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(err.message);
    });
    
  }

  void addBus({String Busid ,String BusPlateNumber,int Capcity,Uint8List image})
  {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString()+"hoksh" +
        '.jpg';


    FirebaseStorage.instance.ref("images").child(fileName).putData(image,SettableMetadata(
      contentType: "image/jpeg"
    )).then(  (url) async {
   var data=   await url.ref.getDownloadURL();

      FirebaseFirestore.instance.collection("Bus").doc(Busid).set({
        "busID":Busid,
        "BusPlateNumber":BusPlateNumber,
        "Capcity":Capcity,
        "imgUrl":data.toString()
      });
    });


    
  }

  void login(BuildContext context,{String email,String password})
  {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) async {
 await SharedPreferences.getInstance().then((value1)  {

  value1.setString("id", value.user.uid);



});








      Fluttertoast.showToast(
          msg:( "loged In"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );


    Navigator.popAndPushNamed(context, "home");

    },onError: (err){

      Fluttertoast.showToast(
          msg:( err as FirebaseAuthException).message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(err.message);
    });



  }

  void createDriver({String nationalId, String driverName, String phone, String password, String email, String busid}) {

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) async {

      await SharedPreferences.getInstance().then((value1)  {

        FirebaseFirestore.instance.collection("driverAccount").doc(value.user.uid).set({
          "nationalId":nationalId,
          "driverName":driverName,
          "phone":phone,
          "password":password,
          "email":email,
          "busid":busid,
          "schoolUid":value1.get("id")

        });

      });


    });

  }

  void createPartner({String nationalId, String partnerName, String phone, String password, String email, String busid, String username}) {
FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)  async {

  await SharedPreferences.getInstance().then((value1)  {


    FirebaseFirestore.instance.collection("pernatsAccount").doc(value.user.uid)
        .set({
      "nationalId":nationalId,
      "parnterName":partnerName,
      "phone":phone,
      "password":password,
      "email":email,
      "username":username,
      "schoolUid": value1.get("id") ,

    })
    ;
    Fluttertoast.showToast(
        msg:("account Created Sccussfly"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

  },onError: (err){
    Fluttertoast.showToast(
        msg:( err as FirebaseAuthException).message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  });




Fluttertoast.showToast(
msg:("account Created Sccussfly"),
toastLength: Toast.LENGTH_SHORT,
gravity: ToastGravity.CENTER,
timeInSecForIosWeb: 1,
backgroundColor: Colors.green,
textColor: Colors.white,
fontSize: 16.0);


  },onError: (err){



  Fluttertoast.showToast(
      msg:( err as FirebaseAuthException).message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
});


  }



  Future<void> createStudent({String nationalId, String studentName, String phone, String classNumber, String parentID, String schoolId,busId }) async {

    await SharedPreferences.getInstance().then((value1) {

      FirebaseFirestore.instance.collection("Students").
          add({
        "nationalId":nationalId,
        "classNumber":classNumber,
        "phone":phone,
        "parentNID":parentID,
        "schoolId":schoolId,
        "schoolUid":value1.get("id"),

        "studentName":studentName,

        "busId":busId

      });



    });


  }

}
 class refress {
  void ref(){

  }

}