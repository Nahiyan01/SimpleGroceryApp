import 'package:flutter/material.dart';

import 'button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancle;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.pink[100],
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //textfield
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter the Money"),
            ),
            //buttons ( save + cancle)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button(
                  text: "Save",
                  onPressed: onSave,
                ),
                Button(
                  text: "Cancle",
                  onPressed: onCancle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
