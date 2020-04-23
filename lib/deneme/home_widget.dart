import 'package:flutter/material.dart';

import 'package:tez_bdt/ui/view/authentication/loading.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Deneme extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = Firestore.instance;
  bool selected = true;
  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final currentuser = await _firebaseAuth.currentUser();
    yield* Firestore.instance
        .collection('userData')
        .document(currentuser.uid)
        .collection('testpoint')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        title: Text('Düşünceleriniz'),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: StreamBuilder(
            stream: getUsersTripsStreamSnapshots(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Loading();
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                      MeetingCard(snapshot: snapshot.data.documents[index]));
            }),
      ),
    );
  }
}

// Define a custom Form widget.
class MeetingCard extends StatefulWidget {
  final db = Firestore.instance;

  final DocumentSnapshot snapshot;

  MeetingCard({this.snapshot});
  @override
  _MeetingCardState createState() => _MeetingCardState();
}

// Define a corresponding State class.
class _MeetingCardState extends State<MeetingCard> {
  bool selected = false;

  // this height is specific to this widget.
  double height = 130;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: () {
        setState(() {
          if (selected == true) {
            selected = false;
          } else {
            selected = true;
          }
        });
      },
      child: AnimatedContainer(
        duration: new Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        height: selected ? 250 : 80,
        
        child: Container(
          width: MediaQuery.of(context).size.width,
          child:Card(
             
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("${widget.snapshot['point']}"),
              
            
              
              ],
          )),
        ),
      ),
    );
  }
}
