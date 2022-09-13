import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_notes_app/pages/addnote.dart';
import 'package:final_notes_app/pages/loginpage.dart';
import 'package:final_notes_app/pages/viewnote.dart';
import 'package:final_notes_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class homePage extends StatefulWidget {
  final String id;
  homePage(this.id);
  @override
  State<homePage> createState() => _homePageState();
}
class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          IconButton(onPressed: ()async{
            await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
            constants.prefs?.setBool("loggedIn", false);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => loginPage())));
          }, icon: Icon(Icons.logout),),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future:FirebaseFirestore.instance.collection("users").doc(widget.id).collection("notes").orderBy("created",descending: true).get() ,
        builder: (context,AsyncSnapshot snapshot) {
        if(snapshot.hasData)
        {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: ((context, index) {
              Map data = snapshot.data.docs[index].data();
              DateTime mydatatime = data['created'].toDate();
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${data["title"]}",style: TextStyle(fontSize: 20),),
                         ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => viewnote(widget.id, data["title"],data["description"],snapshot.data.docs[index].reference)))).then((value) {setState(() {
                            
                          });});
                        },
                      )
                    ],
                  ),
                ),
              );
            }));
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => addnote(widget.id)))).then((value) {setState(() {
          
        });});
      },
      child:Icon(Icons.add),
      ),
    );
  }
}