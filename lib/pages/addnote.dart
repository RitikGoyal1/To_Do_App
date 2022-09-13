import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class addnote extends StatefulWidget {
  String id;
  addnote(this.id);
  @override
  State<addnote> createState() => _addnoteState();
}
class _addnoteState extends State<addnote> {
  String title = "";
  String des = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      ElevatedButton(onPressed: add,
                      child: Text("Save"),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Title",
                        border: UnderlineInputBorder(),
                      ),
                      style:  TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Description",
                        border: UnderlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 20),
                      onChanged: (value) {
                        des = value;
                      },
                      maxLines: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void add()async {
    await FirebaseFirestore.instance.collection("users").doc(widget.id).collection("notes").add({
      "title":title,
      "description": des, 
      "created": DateTime.now(),
    }).then((value) {
      Navigator.pop(context);
    });
  }
}
