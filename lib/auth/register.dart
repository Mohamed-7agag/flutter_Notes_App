// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, body_might_complete_normally_nullable, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> mykey = GlobalKey<FormState>();

  createuser() async {
    if (mykey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        Navigator.of(context).pushReplacementNamed("Login");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'The password provided is too weak.',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'The account already exists for that email.',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              Container(
                height: 200,
                child: Image.asset(
                  "assets/images/note.png",
                ),
              ),
              Text(
                "Register",
                style: TextStyle(fontSize: 35, color: Colors.blue),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Add Your Personal Information",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: mykey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      validator: (value) {
                        if (value == "") {
                          return "Required";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          prefixIcon: Icon(
                            Icons.person_outlined,
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
                      controller: email,
                      validator: (value) {
                        if (value == "") {
                          return "Required";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Your Email",
                          prefixIcon: Icon(
                            Icons.email_outlined,
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
                      controller: password,
                      validator: (value) {
                        if (value == "") {
                          return "Required";
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            size: 28,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await createuser();
                },
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 25),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 13.5),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "have An Account?  ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("Login");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
