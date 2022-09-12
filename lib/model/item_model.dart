// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';

class item_model {
  final String item_name;
  final double item_cost;
  int item_quantity;
  final VoidCallback? add;
  item_model(
      {required this.item_name,
      required this.item_cost,
      required this.item_quantity,
      this.add});

  Map<String, dynamic> toMap() {
    return {
      'item_name': item_name,
      'item_cost': item_cost,
      'item_quantity': item_quantity,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory item_model.fromJson(Map<String, dynamic> json) {
    return item_model(
      item_name: json['item_name'],
      item_cost: json['item_cost'],
      item_quantity: json['item_quantity'],
    );
  }
}
