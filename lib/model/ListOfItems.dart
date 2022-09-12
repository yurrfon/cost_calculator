// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListOfItems extends StatelessWidget {
  final String item_name;
  final double item_cost;
  final int quantity;
  const ListOfItems({
    super.key,
    required this.item_cost,
    required this.item_name,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$quantity orders of  $item_name "),
        Text("${item_cost.toString()}PHP"),
      ],
    );
  }
}
