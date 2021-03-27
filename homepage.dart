import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
class Dict extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Dictbody();
  }
}
class _Dictbody extends State<Dict>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:Column(children: <Widget>[
          SafeArea(child:AppBar(
            backgroundColor: Colors.black87,
            title: Center(
              child: Container(
                margin: EdgeInsets.only(top:14),
                height: 60,
                child: TextField(
                  autofocus: false,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'گەران',
                    prefixIcon: Icon(Icons.search),
                    contentPadding:
                    const EdgeInsets.only(left: 25.0, bottom: 8.0, top: 8.0,),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),),
          Expanded(
               child:  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("dict").snapshots(),
                    builder: (context,snapshot){
                     if(snapshot.hasData){
                       return ListView.builder(
                           itemCount: snapshot.data.documents.length,
                           itemBuilder:(context,index){
                             DocumentSnapshot documentSnapshot =snapshot.data.documents[index];
                             return Card(elevation: 8,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15)
                               ),
                               color: Colors.white,
                               child: ListTile(
                                 leading: Icon(Icons.arrow_right,size:35,color: Colors.amber,),
                                 title: Text(documentSnapshot["word"] ,style: TextStyle(fontWeight: FontWeight.bold),),
                                 subtitle:Text(documentSnapshot["howc"]),
                                 contentPadding: EdgeInsets.all(0.2),
                               ),
                             );
                           }
                           );
                     }else{
                       return Center(
                         child:Loading(indicator: BallPulseIndicator(), size: 80.0,color: Colors.black),);
                  }
                }
            ),
          ),
        ]),
    );
  }
}
