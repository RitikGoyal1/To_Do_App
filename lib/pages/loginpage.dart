import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_notes_app/pages/homepage.dart';
import 'package:final_notes_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Image.asset("assets/image/cover.png"),
              ElevatedButton(
                onPressed: () async {
                  try{GoogleSignIn googleSignIn = GoogleSignIn();
                  final user =  await googleSignIn.signIn() ;
                  if(user!=null){
                    var id = user.id;
                    print(id);

                    FirebaseFirestore.instance.collection("users").doc(user.id).set({
                      "Email": user.email,
                      "Name": user.displayName,
                      "PhotoUrl":user.photoUrl,
                    }).then((value) {
                      constants.prefs?.setBool("loggedIn", true);
                      constants.prefs?.setString("id", id);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => homePage(id))));
                    } );
                  }
                  }
                  catch(e){
                    print(e);
                  }
                },
                child: Text("Sign in with Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
