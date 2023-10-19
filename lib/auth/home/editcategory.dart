// ignore_for_file: sort_child_properties_last, avoid_print, body_might_complete_normally_nullable, dead_code, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, non_constant_identifier_names,

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditCategory extends StatefulWidget {
  final doc_id, oldname;
  const EditCategory({super.key, this.doc_id, this.oldname});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> mykey = GlobalKey<FormState>();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  addcategory() async {
    if (mykey.currentState!.validate()) {
      try {
        categories.doc(widget.doc_id).update({
          "name": name.text,
        });
        Navigator.of(context).pushReplacementNamed("Homepage");
      } catch (e) {
        print("-----------------${e}----------------");
      }
    } else {
      print("----------------NotValid-----------------");
    }
  }

  @override
  void initState() {
    name.text = widget.oldname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Category",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                addcategory();
              },
              child: const Text(
                "Edit",
                style: TextStyle(fontSize: 22),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 60),
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
