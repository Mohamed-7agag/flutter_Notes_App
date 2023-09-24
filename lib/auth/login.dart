// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, body_might_complete_normally_nullable, avoid_print, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, unused_element, unnecessary_brace_in_string_interps, dead_code, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> mykey = GlobalKey<FormState>();

  sign_in() async {
    if (mykey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text);
        Navigator.of(context).pushReplacementNamed("Homepage");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'No user found for that email.',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'Wrong password provided for that user.',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      }
    } else {
      print("---------Not Valid---------");
    }
  }

  google_sign_in() async {
    try {
      Future<UserCredential> signInWithGoogle() async {
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      print("----------------${e}---------------");
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
                "Login",
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
                height: 10,
              ),
              Container(
                child: Text(
                  "Forget Password?",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                alignment: Alignment.topRight,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  await sign_in();
                },
                child: Text(
                  "Login",
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
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  await google_sign_in();
                },
                child: Row(
                  children: [
                    Text(
                      "Login With Google",
                      style: TextStyle(fontSize: 23, color: Colors.blue),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      "assets/images/google.svg",
                      height: 28,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 13.5),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.blue)))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Don't have An Account?  ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("Register");
                    },
                    child: Text(
                      "Register",
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
