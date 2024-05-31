// import 'package:cloud_firestore/cloud_firestore.dart';

// class CartItem {
//   final String id;
//   final String name;
//   final double price;
//   final int quantity;
//   String imageUrl;

//   CartItem({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.quantity,
//     required this.imageUrl,
//   });

//   // // Factory constructor to create a CartItem from Firestore document snapshot
//   // factory CartItem.fromFirestore(DocumentSnapshot doc) {
//   //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//   //   return CartItem(
//   //     id: doc.id,
//   //     name: data['name'],
//   //     price: data['price'].toDouble(),
//   //     quantity: data['quantity'],
//   //   );
//   // }

//   // // Method to convert a CartItem to a Map for Firestore
//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'name': name,
//   //     'price': price,
//   //     'quantity': quantity,
//   //   };
//   // }

//   // Convert a MenuItem object into a map
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'price': price,
//       'imageUrl': imageUrl,
//       'quantity': quantity,
//     };
//   }

//   // Create a MenuItem object from a map
//   factory CartItem.fromMap(Map<String, dynamic> map, String itemId) {
//     return CartItem(
//       id: itemId,
//       name: map['name'],
//       price: map['price'],
//       quantity: map['quantity'],
//       imageUrl: map['imageUrl'],
//     );
//   }

//   factory CartItem.fromDocument(DocumentSnapshot doc) {
//     return CartItem(
//       id: doc.id,
//       name: doc['name'],
//       price: doc['price'],
//       quantity: doc['quantity'],
//       imageUrl: doc['imageUrl'],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onlyu_cafe/model/menu_item.dart';

class CartItem {
  late MenuItem menuItem;
  int quantity;

  CartItem({required this.menuItem, this.quantity = 1});

  // factory CartItem.fromDocument(DocumentSnapshot doc) {
  //   return CartItem(
  //     id: doc.id,
  //     name: doc['name'],
  //     description: doc['description'],
  //     price: doc['price'],
  //     imageUrl: doc['imageUrl'],
  //     isAvailable: doc['isAvailable'],
  //     category: doc['category'],
  //   );
  // }
}
