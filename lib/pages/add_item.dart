// ignore_for_file: camel_case_types

import 'package:cost_calculator/model/item_model.dart';
import 'package:flutter/material.dart';

class add_item extends StatelessWidget {
  final quantity = 1;
  const add_item({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late TextEditingController itemNameController = TextEditingController();
    late TextEditingController itemCostController = TextEditingController();
    late TextEditingController itemQuantityController = TextEditingController();
    TextEditingController();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('ADD NEW ITEM')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              autofocus: true,
              controller: itemNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Item',
              ),
              maxLines: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: itemCostController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cost',
              ),
              maxLines: 1,
            ),
            TextField(
              controller: itemQuantityController..text = '1',
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // labelText: quantity.toString(),
              ),
              maxLines: 1,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  item_model(
                    item_name: itemNameController.text,
                    item_cost: double.parse(itemCostController.text),
                    item_quantity: int.parse(itemQuantityController.text),
                  ),
                );
              },
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    ));
  }
}
