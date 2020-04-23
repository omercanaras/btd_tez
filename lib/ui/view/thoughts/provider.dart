  

import 'package:flutter/material.dart';
import 'package:tez_bdt/core/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Provider extends InheritedWidget {
 final FirebaseAuth auth ;

  Provider({Key key, Widget child, this.auth}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(Provider) as Provider);
}