// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_notes/auth/home/addnote.dart';
import 'package:flutter_application_notes/auth/home/editnote.dart';
import 'package:flutter_application_notes/auth/home/homepage.dart';
import 'package:flutter_application_notes/auth/home/viewnote.dart';

class Notes extends StatefulWidget {
  final doc_id;
  const Notes({super.key, this.doc_id});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
//
  bool isloading = false;
  List<QueryDocumentSnapshot> note_data = [];
  Future getnotes() async {
    isloading = true;
    setState(() {});
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('notes')
        .where("doc_id", isEqualTo: widget.doc_id)
        .get();
    note_data.addAll(query.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getnotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("Homepage");
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNote(doc_id: widget.doc_id),
          ));
        },
        child: Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: isloading == true ? Center(child: CircularProgressIndicator(),) : Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView.builder(
          itemCount: note_data.length,
          itemBuilder: (BuildContext context, int i) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) async {
                await FirebaseFirestore.instance
                    .collection('notes')
                    .doc(note_data[i].id)
                    .delete();
              },
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewNote(
                      title: note_data[i]['title'],
                      note: note_data[i]['note'],
                    ),
                  ));
                },
                child: Card(
                  margin: EdgeInsets.only(top: 10),
                  elevation: 3,
                  child: ListTile(
                      leading: Icon(
                        Icons.note,
                        color: Colors.blue,
                      ),
                      title: Text(
                        note_data[i]['title'],
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        note_data[i]['note'],
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditNote(
                              doc_id: widget.doc_id,
                              oldtitle: note_data[i]['title'],
                              oldnote: note_data[i]['note'],
                              note_id: note_data[i].id,
                            ),
                          ));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 26,
                        ),
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
