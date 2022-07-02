import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class chat extends StatefulWidget{
int index;
String partnerID;
chat({this.index,this.partnerID});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return chateState(index: this.index,partnerID: this.partnerID);
  }
  
}

class chateState extends State<chat>{
  int index;
  String partnerID;
  TextEditingController getText=TextEditingController();
  ScrollController scrollController=ScrollController();

  chateState({this.index,this.partnerID});

String ChatWith="";

  void getChatInfo()
  {
    if(index ==0)
      {
        FirebaseFirestore.instance.collection("pernatsAccount").doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
          setState(() {
            ChatWith=value['schoolUid'];

          });

        });
        
      }
    else if(index==1){

      FirebaseFirestore.instance.collection("pernatsAccount").doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
        setState(() {
          String NationalId=value['nationalId'];
          FirebaseFirestore.instance.collection('Students').where("parentNID",isEqualTo: NationalId).get(

          ).then((value) {

            String BusId =value.docs.first['busId'];
            
            FirebaseFirestore.instance.collection("driverAccount").where("busid",isEqualTo: BusId).get().then((value) {
setState(() {
  ChatWith=value.docs.first.id;

});
            });

          });
          

        });

      });    }

    else if(
    index==3
    ){
      FirebaseFirestore.instance.collection("driverAccount").doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
        setState(() {
          ChatWith=value['schoolUid'];

        });

      });

    }

    else{

      setState(() {
        ChatWith=this.partnerID;
      });
    }
  }


  @override
  void initState() {
    getChatInfo();
    super.initState();
  }

  void SendMessage(){

    if(this.index==2)
    {
      FirebaseFirestore.instance.collection("chat").doc(FirebaseAuth.instance.currentUser.uid+ChatWith).collection(FirebaseAuth.instance.currentUser.uid+ChatWith).add(
          {
            "sender":FirebaseAuth.instance.currentUser.uid,
            "receiver":ChatWith,
            "message":getText.value.text,
            "time":Timestamp.now()
          }

      );
    }
    else{
      FirebaseFirestore.instance.collection("chat").doc(FirebaseAuth.instance.currentUser.uid+ChatWith).collection(FirebaseAuth.instance.currentUser.uid+ChatWith).add(
          {
            "sender":FirebaseAuth.instance.currentUser.uid,
            "receiver":ChatWith,
            "message":getText.value.text,
            "time":Timestamp.now()
          }

      );
    }



    getText.text="";

    scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);



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
      SafeArea(child:   StreamBuilder(builder:(context,AsyncSnapshot<QuerySnapshot> snap){
        return  Stack(
        children: <Widget>[
          ListView.builder(
            controller:scrollController ,
reverse: true,
            itemCount:snap.data.size ,
            shrinkWrap: true,

            padding: EdgeInsets.only(top: 10,bottom: 50),
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                child: Align(
                  alignment: (snap.data.docs[index]["sender"] == ChatWith?Alignment.topLeft:Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (snap.data.docs[index]["sender"] == ChatWith?Colors.grey.shade200:Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(snap.data.docs[index]["message"], style: TextStyle(fontSize: 15),),
                  ),
                ),
              );
            },
          ),

        Align(
        alignment: Alignment.bottomLeft,
        child: Container(
        padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
        children: <Widget>[
        GestureDetector(
        onTap: (){
        },
        child: Container(
        height: 30,
        width: 30,
    decoration: BoxDecoration(
    color: Colors.lightBlue,
    borderRadius: BorderRadius.circular(30),
    ),
    child: Icon(Icons.add, color: Colors.white, size: 20, ),
    ),
    ),
    SizedBox(width: 15,),

          Expanded(

          child: TextField(
              controller: getText,
              decoration: InputDecoration(
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none
              ),
            ) ,) ,

    SizedBox(width: 15,),
    FloatingActionButton(
    onPressed: (){
      SendMessage();
    },
    child: Icon(Icons.send,color: Colors.white,size: 18,),
    backgroundColor: Colors.blue,
    elevation: 0,
    ),
    ],

    ),
    ),
    ),
    ],
    );
      }, stream:index==2? FirebaseFirestore.instance.collection("chat").doc(ChatWith+FirebaseAuth.instance.currentUser.uid).collection(ChatWith+FirebaseAuth.instance.currentUser.uid).orderBy("time",descending: true).snapshots():

      FirebaseFirestore.instance.collection("chat").doc(FirebaseAuth.instance.currentUser.uid+ChatWith).collection(FirebaseAuth.instance.currentUser.uid+ChatWith).orderBy("time",descending: true).snapshots()

      )
      )
    );
  }
  
  
}