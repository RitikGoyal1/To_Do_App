import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class viewnote extends StatefulWidget {
  String id;
  String title;
  String des;
  DocumentReference ref;
  viewnote(this.id, this.title, this.des, this.ref);
  @override
  State<viewnote> createState() => _viewnoteState();
}
class _viewnoteState extends State<viewnote> {
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
                      ElevatedButton(onPressed: update,
                      child: Text("Update"),),
                      ElevatedButton(onPressed: delete,
                      child: Text("Delete"),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: "${widget.title}",
                      decoration: InputDecoration.collapsed(
                        hintText: "Tilte",
                      ),
                      style:  TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                      onChanged: (value){
                        widget.title = value;
                      },
                    ),
                  //  child: Text("${widget.title}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                    initialValue: "${widget.des}",
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration.collapsed(
                        hintText: "Title",
                      ), 
                      onChanged: (value){
                        widget.des = value;
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
  void delete()async{
    widget.ref.delete();
    Navigator.pop(context);
  }
  void update()async{
  //  FirebaseFirestore.instance.collection("users").doc(widget.id);
  widget.ref.update({"title":widget.title,"description":widget.des,"created":DateTime.now()});
  Navigator.pop(context);
  }
}
