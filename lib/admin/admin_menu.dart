// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:onlyu_cafe/admin/admin_order.dart';
// import 'package:onlyu_cafe/product_management/add_menu_item.dart';
// import 'package:onlyu_cafe/model/menu_item.dart';

// class AdminMenuPage extends StatefulWidget {
//   const AdminMenuPage({super.key});

//   @override
//   State<AdminMenuPage> createState() => _AdminMenuPageState();
// }

// class _AdminMenuPageState extends State<AdminMenuPage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<MenuItem> _menuItems = [];
//   bool _isFetchingMenuItems = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchMenuItems();
//   }

//   Future<void> _fetchMenuItems() async {
//     setState(() {
//       _isFetchingMenuItems = true;
//     });

//     try {
//       QuerySnapshot snapshot = await _firestore.collection('menu_items').get();
//       List<MenuItem> fetchedMenuItems =
//           snapshot.docs.map((doc) => MenuItem.fromDocument(doc)).toList();
//       setState(() {
//         _menuItems = fetchedMenuItems;
//       });
//     } catch (e) {
//       print('Error fetching menu items: $e');
//     }

//     setState(() {
//       _isFetchingMenuItems = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Menu Items')),
//       body: _isFetchingMenuItems
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _menuItems.length,
//               itemBuilder: (context, index) {
//                 MenuItem menuItem = _menuItems[index];
//                 return ListTile(
//                   leading: menuItem.imageUrl.isNotEmpty
//                       ? Image.network(menuItem.imageUrl,
//                           width: 50, height: 50, fit: BoxFit.cover)
//                       : Icon(Icons.image),
//                   title: Text(menuItem.name),
//                   subtitle: Text(
//                       '${menuItem.description}\n${menuItem.price.toStringAsFixed(2)}'),
//                   isThreeLine: true,
//                   trailing: menuItem.isAvailable
//                       ? Icon(Icons.check_circle, color: Colors.green)
//                       : Icon(Icons.cancel, color: Colors.red),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlyu_cafe/model/menu_item.dart';

class AdminMenuPage extends StatefulWidget {
  const AdminMenuPage({super.key});

  @override
  State<AdminMenuPage> createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to toggle the availability of a menu item
  Future<void> _toggleAvailability(MenuItem menuItem) async {
    try {
      await _firestore.collection('menu_items').doc(menuItem.id).update({
        'isAvailable': !menuItem.isAvailable,
      });
    } catch (e) {
      print('Error updating availability: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Items')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('menu_items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching menu items'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No menu items found'));
          }

          List<MenuItem> menuItems = snapshot.data!.docs
              .map((doc) => MenuItem.fromDocument(doc))
              .toList();

          return ListView.separated(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              MenuItem menuItem = menuItems[index];
              return ListTile(
                leading: menuItem.imageUrl.isNotEmpty
                    ? Image.network(menuItem.imageUrl,
                        width: 60, height: 60, fit: BoxFit.cover)
                    : Icon(Icons.image),
                title: Text(menuItem.name),
                subtitle: Text(
                    '${menuItem.description}\n${menuItem.price.toStringAsFixed(2)}'),
                isThreeLine: true,
                trailing: Switch(
                  activeColor: Colors.green,
                  value: menuItem.isAvailable,
                  onChanged: (value) {
                    _toggleAvailability(menuItem);
                  },
                ),
                onTap: () {
                  print('Tap');
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
