// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, body_might_complete_normally_nullable, sort_child_properties_last, unnecessary_brace_in_string_interps, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_notes/auth/home/notes.dart';

class AddNote extends StatefulWidget {
  final doc_id;
  const AddNote({super.key, this.doc_id});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
//
  bool isloading = false;
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  GlobalKey<FormState> mykey = GlobalKey<FormState>();

  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  addnote() async {
    if (mykey.currentState!.validate()) {
      try {
        await notes.add(
            {"title": title.text, "note": note.text, "doc_id": widget.doc_id});
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Notes(
            doc_id: widget.doc_id,
          ),
        ));
      } catch (e) {
        print("-----------------${e}----------------");
      }
    } else {
      print("----------------NotValid-----------------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Form(
              key: mykey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    validator: (value) {
                      if (value == "") {
                        return "Required";
                      }
                    },
                    maxLength: 30,
                    decoration: InputDecoration(
                        hintText: "Title",
                        prefixIcon: Icon(
                          Icons.title,
                          size: 28,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: note,
                    validator: (value) {
                      if (value == "") {
                        return "Required";
                      }
                    },
                    maxLines: 6,
                    decoration: InputDecoration(
                        hintText: "Note",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                addnote();
              },
              child: Text(
                "Add",
                style: TextStyle(fontSize: 25),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 15, horizontal: 65),
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
            ),
          ],
        ),
      ),
    );
  }
}
