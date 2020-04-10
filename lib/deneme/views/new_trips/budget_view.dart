import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tez_bdt/deneme/models/Trip.dart';

class NewTripBudgetView extends StatelessWidget {
  final db = Firestore.instance;

  final Trip trip;
  NewTripBudgetView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Create Trip - Budget'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Finish"),
                Text("Location ${trip.title}"),
                Text("Start Date ${trip.startDate}"),
                Text("End Date ${trip.endDate}"),

                RaisedButton(
                  child: Text("Finish"),
                  onPressed: () async {
                    
                    await db.collection("trips").add(trip.toJson());
                    print("a");
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            )
        )
    );
  }
}
