// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print, body_might_complete_normally_nullable, dead_code, unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool isloading = false;
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> mykey = GlobalKey<FormState>();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  addcategory() async {
    if (mykey.currentState!.validate()) {
      try {
        
        await categories.add(
            {"name": name.text, "id": FirebaseAuth.instance.currentUser!.uid});
        
        Navigator.of(context).pushReplacementNamed("Homepage");
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
        title: Text("Add Category"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: double.infinity,
        child: Column(
          children: [
            Form(
              key: mykey,
              child: TextFormField(
                controller: name,
                validator: (value) {
                  if (value == "") {
                    return "Required";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Category Name",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                addcategory();
              },
              child: Text(
                "Add",
                style: TextStyle(fontSize: 25),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 14.5, horizontal: 75),
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
