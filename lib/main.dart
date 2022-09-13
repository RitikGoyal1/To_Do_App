import 'package:final_notes_app/pages/homepage.dart';
import 'package:final_notes_app/pages/loginpage.dart';
import 'package:final_notes_app/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  constants.prefs =await SharedPreferences.getInstance();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: constants.prefs?.getBool("loggedIn")==true ? homePage(constants.prefs!.getString("id")??"") : loginPage(),
    );
  }
}
