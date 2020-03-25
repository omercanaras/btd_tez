import 'package:flutter/material.dart';
import 'package:tez_bdt/core/helper/shared_manager.dart';
import 'package:tez_bdt/ui/view/authentication/loading.dart';
import 'package:tez_bdt/ui/view/authentication/login_view.dart';
import 'package:tez_bdt/ui/view/depressionTest/depression_start.dart';
import 'package:tez_bdt/ui/view/depressionTest/questions.dart';
import 'package:tez_bdt/ui/view/home/fire_home.dart';
import 'package:tez_bdt/ui/view/home/home_view.dart';
import 'package:tez_bdt/ui/view/home/screen.dart';
 
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