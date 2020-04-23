import 'package:flutter/material.dart';

import 'package:tez_bdt/ui/view/authentication/loading.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ThoughtScreen extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = Firestore.instance;

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
                      ThoughtCard(snapshot: snapshot.data.documents[index]));
            }),
      ),
    );
  }
}

// Define a custom Form widget.
class ThoughtCard extends StatefulWidget {
  final db = Firestore.instance;

  final DocumentSnapshot snapshot;

  ThoughtCard({this.snapshot});
  @override
  _MeetingCardState createState() => _MeetingCardState();
}

// Define a corresponding State class.
class _MeetingCardState extends State<ThoughtCard> {
  bool selected = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = Firestore.instance;
  // this height is specific to this widget.
  double height = 130;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: new Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      height: selected ? 290 : 96,
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Card(
            elevation: 3,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: GestureDetector(
                    child: Text(
                      "${widget.snapshot['point']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() {
                        if (selected == true) {
                          selected = false;
                        } else {
                          selected = true;
                        }
                      });
                    },
                  ),
                  subtitle: GestureDetector(
                    child: Text("${widget.snapshot['point']}"),
                    onTap: () {
                      setState(() {
                        if (selected == true) {
                          selected = false;
                        } else {
                          selected = true;
                        }
                      });
                    },
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      
                      IconButton(
                        icon: selected ? Icon(Icons.keyboard_arrow_up):Icon(Icons.keyboard_arrow_down),
                        onPressed: () {
                          setState(() {
                            if (selected == true) {
                              selected = false;
                            } else {
                              selected = true;
                            }
                          });
                        },
                        tooltip: 'more',
                      ),
                    ],
                  ),
                  onLongPress: () {},
                ),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                          title: Text("merhaba",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54)),
                          trailing: GestureDetector(
                            onTap: () async {
                              final currentuser =
                                  await _firebaseAuth.currentUser();

                              setState(() {
                                db
                                    .collection("userData")
                                    .document(currentuser.uid)
                                    .collection("testpoint")
                                    .document(widget.snapshot.documentID)
                                    .delete();
                              });
                            },
                            child: Text("Sil"),
                          )),
                    ),
                    Expanded(
                      child: ListTile(
                          title: Text("merhaba",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54)),
                          trailing: GestureDetector(
                            onTap: () {
                              if (selected == true) {
                                selected = false;
                              } else {
                                selected = true;
                              }
                            },
                            child: Text("Up"),
                          )),
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
