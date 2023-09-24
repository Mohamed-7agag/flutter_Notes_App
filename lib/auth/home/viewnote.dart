// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final title;
  final note;
  const ViewNote({super.key, this.title, this.note});

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Note",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            Text(
              "Title",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${widget.title}",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              "Note",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${widget.note}",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                height: 1.6
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
