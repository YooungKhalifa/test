import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Addword extends StatefulWidget {
  @override
  _AddwordState createState() => _AddwordState();
}

class _AddwordState extends State<Addword> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Card(
                elevation: 15,
                child: Container(
                  padding: EdgeInsets.only(left: 30,right: 30,),
                  height: MediaQuery.of(context).size.height-550,
                  width: MediaQuery.of(context).size.width-50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MyCustomForm(),

          ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(elevation: 20,
                child:  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("sugwords").snapshots(),
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
                                  leading: Icon(Icons.check,size:35,color: Colors.amber,),
                                  title: Text(documentSnapshot["word"] ,style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle:Text(documentSnapshot["howc"]),
                                  contentPadding: EdgeInsets.all(0.2),
                                ),
                              );
                            }
                        );
                      }else{
                        return Center(
                          child:Text("No Suggestions"));
                      }
                    }
                ),
              ),
            ),
            FloatingActionButton(elevation: 20,
              onPressed: () {
              Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,color: Colors.black,),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    ),);
  }
}
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed:(){
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}



