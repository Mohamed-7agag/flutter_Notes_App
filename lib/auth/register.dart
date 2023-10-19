// ignore_for_file:sort_child_properties_last, sized_box_for_whitespace, body_might_complete_normally_nullable, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                "Register",
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
                      controller: name,
                      validator: (value) {
                        if (value == "") {
                          return "Required";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
                          hintStyle: const TextStyle(fontSize: 13),
                          prefixIcon: const Icon(
                            Icons.person_outlined,
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
                      controller: email,
                      validator: (value) {
                        if (value == "") {
                          return "Required";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Enter Your Email",
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
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
                          hintText: "Enter Your Password",
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
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
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await createuser();
                },
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 13.5),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const Text(
                    "have An Account?  ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("Login");
                    },
                    child: const Text(
                      "Login",
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
