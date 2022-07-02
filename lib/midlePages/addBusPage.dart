import 'dart:async';
import 'dart:html' ;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addBus extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
return addBusState();  }

}

class addBusState extends State<addBus>{

  TextEditingController busid=new TextEditingController();
  TextEditingController BusPlateNumber=new TextEditingController();
  TextEditingController Capcity=new TextEditingController();

  ScrollController scrollController=new ScrollController();

  Uint8List imag;


  Future<Uint8List> pickImage() async {
    print('FirebaseImageStorageRepositoryWeb.pickImage() started');
    final completer = Completer<Uint8List>();
    final InputElement input = document.createElement('input');
    input
      ..type = 'file'
      ..multiple = true
      ..accept = 'image/*';
    input.click();
    // onChange doesn't work on mobile safari
    input.addEventListener('change', (e) async {
      final List<File> files = input.files;
      Iterable<Future<Uint8List>> resultsFutures = files.map((file) {
        final reader = FileReader();
        reader.readAsArrayBuffer(files.first); // .readAsDataUrl(file);
        reader.onError.listen((error) => completer.completeError(error));
        return reader.onLoad.first.then((_) => reader.result);
      });

      final results = await Future.wait(resultsFutures);
      completer.complete(results.first);
    });
    // need to append on mobile safari
    document.body.append(input);
    // input.click(); can be here
    final Uint8List image = await completer.future;
    input.remove();
    return image;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(


      child: Column(


        children: [
          Text("Add Bus Information"),
          Container
            (
margin: EdgeInsets.all(5),
            width:  MediaQuery.of(context).size.width*(1/5),
            height: 30,


            child: TextField(
controller: busid,
              decoration: InputDecoration(


                  hintText: "Bus Id",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid
                      )
                  )
              ),
            ),
          ),
          Container
            (
            margin: EdgeInsets.all(5),

            width:  MediaQuery.of(context).size.width*(1/5),
            height: 30,
            child: TextField(
controller: BusPlateNumber,
              decoration: InputDecoration(

                  hintText: "Bus plate number",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid
                      )
                  )
              ),
            ),
          ),
          Container
            (
            margin: EdgeInsets.all(5),

            width:  MediaQuery.of(context).size.width*(1/5),
            height: 30,

            child: TextField(
              controller: Capcity,

              decoration: InputDecoration(

                  hintText: "capacity",
                  border: OutlineInputBorder(

                      borderSide: BorderSide(

                          style: BorderStyle.solid
                      )
                  )
              ),
            ),
          ),

          InkWell(
            child: Image.asset("icons/inserticon.png",width: 50,height: 50,),
          onTap: ()  {
              setState(() async {

                imag=await  pickImage();

              });
          },

            ),
          ElevatedButton(onPressed: () {
server(null).addBus(Busid: busid.value.text
    ,BusPlateNumber: BusPlateNumber.value.text,Capcity: int.parse( Capcity.value.text),image: imag);

          }, child: Text(
            "Add"
          ),

          ),
          Divider(thickness: 1,color: Colors.black,),


          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Bus").snapshots(),
            builder:  (BuildContext context,AsyncSnapshot<QuerySnapshot> snap){

              if(!snap.hasData)
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );                }

                  return SizedBox(
                    width: 800,
                    height: 300,

                    child:   Scrollbar(
                      controller: scrollController,
                      isAlwaysShown: true,
                      child:   GridView.count(
controller: scrollController,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        scrollDirection: Axis.vertical,

                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 2,

                        // Generate 100 widgets that display their index in the List.
                        children:
                        List.generate(snap.data.size, (index) {

                          return

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,

                                    )
                                  ]


                              ),
                              child:  Column(

                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,

                                    children: [
                                      Text("BusID:",
                                        style: TextStyle(

                                            color: Colors.orange
                                        ),),
                                      Text(snap.data.docs.elementAt(index).data()['busID'].toString(),style:
                                      TextStyle(

                                          color: Colors.black38
                                      ),)

                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,

                                    children: [
                                      Text("BusPlateNumber:",style: TextStyle(

                                          color: Colors.orange
                                      ),),
                                      Text(snap.data.docs.elementAt(index).data()['BusPlateNumber'].toString(),style:TextStyle(

                                          color: Colors.black38
                                      ))

                                    ],
                                  )
                                  ,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,

                                    children: [
                                      Text("Capcity:",style: TextStyle(

                                          color: Colors.orange
                                      ),),
                                      Text(snap.data.docs.elementAt(index).data()['Capcity'].toString(),style:TextStyle(

                                          color: Colors.black38
                                      ))
                                      ,




 Image.network(snap.data.docs.elementAt(index).data()['imgUrl'].toString(),   headers: {"header": "value"}),

                                    ],
                                  )

                                ],
                              ),
                            )
                          ;
                        }),
                      ),
                    )
                  ,
                  );





            },
          )



        ]
      )
      );

  }

}