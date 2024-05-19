import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onlyu_cafe/model/menu_item.dart';

Future<void> addMenuItem(MenuItem menuItem) async {
  await FirebaseFirestore.instance.collection('menu_items').add(menuItem.toMap());
}

Future<List<MenuItem>> getMenuItems() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('menu_items').get();
  return snapshot.docs.map((doc) => MenuItem.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
}