// ignore_for_file: prefer_typing_uninitialized_variables

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
        title: const Text(
          "View Note",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            const Text(
              "Title",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "${widget.title}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Note",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "${widget.note}",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500, height: 1.6),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
