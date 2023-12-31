// ignore_for_file:use_build_context_synchronously, unused_local_variable, await_only_futures

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_notes/auth/home/editcategory.dart';
import 'package:flutter_application_notes/auth/home/notes.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isloading = false;
  List<QueryDocumentSnapshot> data = [];
  Future getdata() async {
    isloading = true;
    setState(() {});
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('categories').where("id" , isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    data.addAll(query.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Homepage",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("Login", (route) => false);
              },
              icon: const Icon(
                Icons.exit_to_app,
                size: 25,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("AddCategory");
        },
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: isloading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisExtent: 135),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onLongPress: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        desc: 'Choose What You Want',
                        btnOkText: "Edit",
                        btnCancelText: "Delete",
                        btnCancelOnPress: () async {
                          await FirebaseFirestore.instance
                              .collection('categories')
                              .doc(data[i].id)
                              .delete();
                          Navigator.of(context)
                              .pushReplacementNamed("Homepage");
                        },
                        btnOkOnPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditCategory(
                                doc_id: data[i].id, oldname: data[i]['name']),
                          ));
                        },
                      ).show();
                    },
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Notes(doc_id: data[i].id),
                      ));
                    },
                    child: Card(
                      elevation: 0.5,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/folder.png",
                            width: 85,
                          ),
                          Text(
                            data[i]['name'],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
