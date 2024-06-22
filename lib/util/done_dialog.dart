import 'package:flutter/material.dart';

import 'button.dart';

class DoneDialog extends StatelessWidget {
  final controller;
  dynamic text;
  VoidCallback onDone;
  VoidCallback onCancle;
  DoneDialog({
    super.key,
    required this.controller,
    required this.text,
    required this.onDone,
    required this.onCancle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.pink.shade100,
      content: Container(
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "Enter the price", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "The total price = $text",
              style: const TextStyle(fontSize: 12.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button(
                  text: "Done",
                  onPressed: onDone,
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
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none),
    );
  }
}
