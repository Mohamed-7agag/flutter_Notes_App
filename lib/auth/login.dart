// ignore_for_file:sort_child_properties_last, sized_box_for_whitespace, body_might_complete_normally_nullable, avoid_print, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, unused_element, unnecessary_brace_in_string_interps, dead_code, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Container(
                height: 200,
                child: Image.asset(
                  "assets/images/note.png",
                ),
              ),
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, color: Colors.blue),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Add Your Personal Information",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          hintText: "Enter Your Email",
                          hintStyle: const TextStyle(fontSize: 13),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 25,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                    ),
                    const SizedBox(
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          hintText: "Enter Your Password",
                          hintStyle: const TextStyle(fontSize: 13),
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            size: 25,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child:  Text(
                  "Forget Password?",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13,color: Colors.grey[600],fontStyle: FontStyle.italic),
                ),
                alignment: Alignment.topRight,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: ()  {
                   sign_in();
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0.5),

                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 13.5),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: ()  {
                   google_sign_in();
                },
                child: Row(
                  children: [
                    const Text(
                      "Login With Google",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    const SizedBox(
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
                  elevation: MaterialStateProperty.all(0.5),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 13.5),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.blue)))),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const Text(
                    "Don't have An Account?  ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("Register");
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 14,
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
