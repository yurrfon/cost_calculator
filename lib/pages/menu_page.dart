import 'package:cost_calculator/model/ListOfItems.dart';
import 'package:cost_calculator/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_item.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.title});
  final String title;

  @override
  State<MenuPage> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  @override
  void initState() {
    cost = 0;
    totalCost = 0.0;
    Hive.deleteBoxFromDisk('item_list');
    super.initState();
  }

  double cost = 0.0;
  double totalCost = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(
            'Total Cost is: $totalCost PHP',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SingleChildScrollView(
            child: FutureBuilder<Box>(
              future: Hive.openBox('item_list'),
              builder: (context, todoBox) {
                if (todoBox.data != null) {
                  final data = todoBox.data?.values.toList() ?? [];
                  final items = data.map((e) {
                    final cast = Map<String, dynamic>.from(e);
                    return item_model.fromJson(cast);
                  }).toList();

                  return ValueListenableBuilder(
                    valueListenable: todoBox.data!.listenable(),
                    builder: ((context, box, widget) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          for (int i = 0; i < items.length; i++) ...{
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ListOfItems(
                                      item_cost: items[i].item_cost,
                                      item_name: items[i].item_name,
                                      quantity: items[i].item_quantity,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: ElevatedButton(
                                            onPressed: (() {
                                              setState(() {
                                                func(
                                                    item_model(
                                                        item_name:
                                                            items[i].item_name,
                                                        item_cost:
                                                            items[i].item_cost,
                                                        item_quantity: items[i]
                                                            .item_quantity),
                                                    true,
                                                    i);
                                              });
                                            }),
                                            child: const Text('+'),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(0),
                                          margin: const EdgeInsets.all(0),
                                          width: 30,
                                          height: 30,
                                          child: ElevatedButton(
                                            onPressed: (() {
                                              setState(() {
                                                func(
                                                    item_model(
                                                        item_name:
                                                            items[i].item_name,
                                                        item_cost:
                                                            items[i].item_cost,
                                                        item_quantity: items[i]
                                                            .item_quantity),
                                                    false,
                                                    i);
                                              });
                                            }),
                                            child: const Text('-'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          },
                        ],
                      );
                    }),
                  );
                }
                return const Center(
                  child: Text('No Items in list yet'),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      //print('duuuddeeee');
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const add_item();
                      })).then((value) {
                        if (value is item_model) {
                          setState(() {
                            //print(value.item_cost);
                            cost = 0;
                            cost += value.item_cost.toDouble();
                            cost *= value.item_quantity;
                            totalCost += cost;
                            final todobox = Hive.box('item_list');
                            todobox.add(value.toMap());
                          });
                        }
                      });
                    },
                    child: const Text('ADD ITEM'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final todobox = Hive.box('item_list');
                        todobox.clear();
                        cost = 0;
                        totalCost = 0;
                      });
                    },
                    child: const Text('CLEAR'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void func(item_model val, bool willAdd, int index) {
    final todoBox = Hive.box('item_list');
    cost = 0;
    cost += val.item_cost.toDouble();
    if (willAdd) {
      //add the # of items
      val.item_quantity += 1;
      totalCost += cost;
    } else {
      //subtract the items
      val.item_quantity -= 1;
      totalCost -= cost;
      if (val.item_quantity == 0) {
        todoBox.deleteAt(index);
        return;
      }
    }

    //both action has this
    todoBox.putAt(index, val.toMap());
  }
}
