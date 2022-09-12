// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:todo_app/groceries/items/grocery_form_page.dart';
// import 'package:todo_app/models/item_model.dart';
// import 'package:todo_app/widgets/item_button.dart';
// import '../items/grocery_item_details_page.dart';
// import '../items/grocery_item.dart';

// / This is an example todo app
// / using local database persistence
// / and Hive NoSQL database.
// class GroceriesPage extends StatefulWidget {
//   const GroceriesPage({Key? key}) : super(key: key);

//   @override
//   State<GroceriesPage> createState() => _GroceriesPageState();
// }

// class _GroceriesPageState extends State<GroceriesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Groceries'),
//       ),
//       body: Center(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               / This is an example of how we can
//               / open the box so we can use it later.
//               /
//               / `FutureBuilder` is a widget that is use to
//               /
//               /  used to wait
//               / for data that needs time before use. In this
//               / case, opening a box that stores oure
//               / data may require some time before load
//               child: FutureBuilder<Box>(
//                   future: Hive.openBox('todo_items'),
//                   builder: (context, todoBox) {
//                     print("adding to list!");
//                     if (todoBox.data != null) {
//                       / This is how we read data from the hive
//                       / database.
//                       final data = todoBox.data?.values.toList() ?? [];
//                       final items = data.map((e) {
//                         final cast = Map<String, dynamic>.from(e);
//                         return ItemModel.fromJson(cast);
//                       }).toList();

//                       return ValueListenableBuilder(
//                         valueListenable: todoBox.data!.listenable(),
//                         builder: (context, box, widget) {
//                           return Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               for (int i = 0; i < items.length; i++)
//                                 GroceryItem(
//                                   title: items[i].title,
//                                   description: items[i].description,
//                                   date: items[i].date,
//                                   onItemPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(builder: (_) {
//                                         return GroceryItemDetailsPage(
//                                           id: i,
//                                           itemModel: items[i],
//                                           onItemUpdated: (bool isUpdated) {
//                                             if (isUpdated) {
//                                               setState(() {});
//                                             }
//                                           },
//                                           onItemDeleted: () {
//                                             setState(() {
//                                               final box = Hive.box(
//                                                 'todo_items',
//                                               );
//                                               box.deleteAt(i);
//                                             });
//                                           },
//                                         );
//                                       }),
//                                     );
//                                   },
//                                 )
//                             ],
//                           );
//                         },
//                       );
//                     }

//                     return const Center(
//                       child: Text('No items found.'),
//                     );
//                   }),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: ItemButton(
//                 title: 'New Item',
//                 color: Colors.green,
//                 onItemPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) {
//                       print("Getting inside GroceryFormPage()");
//                       return const GroceryFormPage(
//                         itemModel: null,
//                         mode: GroceryFormMode.add,
//                       );
//                     }),
//                   ).then((value) {
//                     / This checks if the value from the
//                     / previous route is an instance of
//                     / `ItemModel`. If so, read
//                     / the value accordingly.
//                     if (value is ItemModel) {
//                       / `setState` notifies the Flutter
//                       / to rebuild the UI
//                       setState(() {
//                         final todoBox = Hive.box('todo_items');
//                         todoBox.add(value.toMap());
//                       });
//                     }
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class GroceryItem extends StatelessWidget {
//   final String title;
//   final String description;
//   final String date;

//   / This is used for passing a custom
//   / function callback when the `InkWell`
//   / in this widget is pressed.
//   final VoidCallback? onItemPressed;

//   const GroceryItem({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.date,
//     this.onItemPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       / This is how you use the custom function callback.
//       onTap: onItemPressed,
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               height: 100,
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(description),
//                   Text(date),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
