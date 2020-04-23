import 'package:flutter/material.dart';
import 'package:tez_bdt/core/helper/shared_manager.dart';
import 'package:tez_bdt/core/services/services2.dart';
import 'package:tez_bdt/deneme/home_widget.dart';
import 'package:tez_bdt/deneme/views/home_view.dart';

import 'package:tez_bdt/ui/view/authentication/login_view.dart';
import 'package:tez_bdt/ui/view/thoughts/thoughts.dart';

 
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized() ;
  await SharedManager.init();
  runApp(MyApp());
  }
 
class MyApp extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',

      home: LoginView()
    );
  }
}