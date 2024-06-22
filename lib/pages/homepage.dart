import 'package:flutter/material.dart';
import 'package:grocery_list_app/util/done_dialog.dart';
import 'package:grocery_list_app/util/grocery_tile.dart';

import '../util/dialog_box.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _dialogcontroller = TextEditingController();

  final _controller = TextEditingController();

  final _doneController = TextEditingController();

  dynamic _amount = 0;

  List _groceryList = [
    ["chicken", "4", ""],
    ["potato", "10", "kg"],
    ["eggplant", "2", "kg"],
  ];

  //on pressing floating button
  void createNewTile() {
    String input = _controller.text.trim();
    String? _item;
    String? _quantity;
    String? _scale;

    if (input.isNotEmpty) {
      List<String> parts = input.split(" ");
      if (parts.length >= 3) {
        _item = parts.sublist(0, parts.length - 2).join(' ');
        _quantity = parts[parts.length - 2];
        _scale = parts.last;
      } else if (parts.length == 2) {
        _item = parts[0];
        _quantity = parts[1];
        _scale = "";
      } else if (parts.length == 1) {
        _item = parts[0];
        _quantity = "";
        _scale = "";
      }
    }

    setState(() {
      if (_item != null && _quantity != null && _scale != null) {
        _groceryList.add([_item, _quantity, _scale]);
      }
      _controller.clear();
    });
  }

  //save starting amount of money
  dynamic saveAmount() {
    setState(() {
      _amount = _dialogcontroller.text as int;
      _dialogcontroller.clear();
    });
    Navigator.of(context).pop;
  }

  //show dialogbox
  void enterTotalAmount() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _dialogcontroller,
          onSave: saveAmount,
          onCancle: Navigator.of(context).pop,
        );
      },
    );
  }

  //onDone's Text thing under the textfield
  dynamic individualPrice(int index) {
    dynamic perUnit = _doneController.text as dynamic;
    dynamic result;
    if (_groceryList[index][1] <= 999) {
      var price = (_groceryList[index][1] / 1000);
      result = price * perUnit;
      return result;
    } else {
      result = _groceryList[index][1] * perUnit;
      return result;
    }
  }

  //onDone in the Slidable
  void actuallyBuyingIt() {}

  //buying an Item
  void buyingIt(int index) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, a1, a2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: DoneDialog(
                controller: _doneController,
                text: individualPrice(index),
                onDone: actuallyBuyingIt,
                onCancle: Navigator.of(context).pop,
              )),
        );
      },
    );
  }

  //delete item from list
  void deleteTask(int index) {
    setState(() {
      _groceryList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.pink[200],
          title: const Center(child: Text("Grocery App")),
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        enterTotalAmount();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 25.0),
                        decoration: BoxDecoration(
                            color: Colors.pink.shade200,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              //dark shadow on the bottom
                              BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(6, 6),
                                blurRadius: 7,
                                spreadRadius: 1,
                              ),
                              //light shadow on the top
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-6, -6),
                                blurRadius: 7,
                                spreadRadius: 1,
                              )
                            ]),
                        child: Center(
                            child: Text(
                          "Money left $_amount",
                          style: const TextStyle(fontSize: 18.0),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 25.0),
                      decoration: BoxDecoration(
                          color: Colors.pink.shade200,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                offset: const Offset(10, 10),
                                blurRadius: 7)
                          ]),
                      child: Center(
                          child: Text(
                        'Total Items left ${_groceryList.length}',
                        style: const TextStyle(fontSize: 18.0),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _groceryList.length,
                itemBuilder: (context, index) {
                  return GroceryTile(
                    itemname: _groceryList[index][0],
                    quantity: _groceryList[index][1],
                    scale: _groceryList[index][2],
                    buyIt: (context) => buyingIt(index),
                    deleteFunction: (context) => deleteTask(index),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: const FractionalOffset(0.0, 1.0),
                        child: SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                                fillColor: Colors.blue,
                                border: OutlineInputBorder(),
                                hintText: "Enter a new Item and the amount "),
                          ),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: createNewTile,
                        child: const Icon(Icons.add),
                      ),
                    ))
              ],
            )
          ],
        ));
  }
}
