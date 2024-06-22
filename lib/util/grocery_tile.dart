import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroceryTile extends StatelessWidget {
  final String itemname;
  final String quantity;
  final String scale;
  Function(BuildContext)? buyIt;
  Function(BuildContext)? deleteFunction;
  GroceryTile(
      {super.key,
      required this.itemname,
      required this.quantity,
      required this.scale,
      required this.buyIt,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: buyIt,
              icon: Icons.check_outlined,
              backgroundColor: Colors.green.shade400,
              borderRadius: BorderRadius.circular(12.0),
            )
          ],
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(12.0),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.pink[200],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                itemname,
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                width: 220.0,
              ),
              Text(
                quantity,
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                scale,
                style: const TextStyle(fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
