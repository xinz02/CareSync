// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:onlyu_cafe/main.dart';
// // import 'package:onlyu_cafe/main.dart';
// import 'package:onlyu_cafe/service/auth.dart';
// import 'package:onlyu_cafe/user_management/login.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HomePage extends StatefulWidget {
//   // final VoidCallback
//   //     onNavigateToMenu; // A callback function to switch to the Menu tab.

//   // HomePage({super.key, required this.onNavigateToMenu});
//   final void Function(String)
//       onButtonPressed; // Callback to navigate and set order type

//   HomePage({super.key, required this.onButtonPressed});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String _username = 'guest';
//   // String _role = 'guest';
//   String _role = '';

//   @override
//   void initState() {
//     super.initState();
//     _getUserData();
//   }

//   Future<void> _getUserData() async {
//     final User? user = _auth.currentUser;

//     if (user != null) {
//       final DocumentSnapshot userData =
//           await _firestore.collection('User').doc(user.uid).get();

//       if (userData.exists) {
//         final String name = userData.get('name');
//         final String role = userData.get('role');
//         print('User name: $name');
//         print('User role: $role');

//         setState(() {
//           // Update the _username variable
//           _username = name;
//         });
//       } else {
//         print('User data not found');
//       }
//     } else {
//       setState(() {
//         // Update the _username variable
//         _username = 'guest';
//         _role = '567';
//       });
//       print('User not logged in');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 248, 240, 238),
//       // body: Center(child: Text("Home Page")),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Image.asset(
//                     "assets/images/logo.png",
//                     height: 220,
//                   ),
//                   //test here
//                   // Text('$_role'),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   //   children: [
//                   //     ElevatedButton(
//                   //         onPressed: () {
//                   //           widget.onButtonPressed(
//                   //               'dine in'); // Pass 'dine in' to navigate to the Menu tab
//                   //         },
//                   //         style: ElevatedButton.styleFrom(
//                   //             backgroundColor:
//                   //                 const Color.fromARGB(255, 246, 231, 232),
//                   //             padding: const EdgeInsets.symmetric(
//                   //                 vertical: 35, horizontal: 52),
//                   //             elevation: 2,
//                   //             shape: RoundedRectangleBorder(
//                   //                 borderRadius: BorderRadius.circular(10))),
//                   //         child: const Text(
//                   //           "Dine In",
//                   //           style: TextStyle(fontSize: 16),
//                   //         )),
//                   //     ElevatedButton(
//                   //         onPressed: () {
//                   //           widget.onButtonPressed(
//                   //               'pick up'); // Pass 'dine in' to navigate to the Menu tab
//                   //         },
//                   //         style: ElevatedButton.styleFrom(
//                   //             backgroundColor:
//                   //                 const Color.fromARGB(255, 246, 231, 232),
//                   //             padding: const EdgeInsets.symmetric(
//                   //                 vertical: 35, horizontal: 52),
//                   //             elevation: 2,
//                   //             shape: RoundedRectangleBorder(
//                   //                 borderRadius: BorderRadius.circular(10))),
//                   //         child: const Text(
//                   //           "Pick Up",
//                   //           style: TextStyle(fontSize: 16),
//                   //         )),
//                   //   ],
//                   // ),
//                   // const SizedBox(height: 20),
//                   Container(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Text(
//                       "Welcome back, $_username!",
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//           SliverPersistentHeader(
//               pinned: true,
//               delegate: _StickyHeaderDelegate(
//                   minHeight: 55,
//                   maxHeight: 70,
//                   child: Container(
//                     color: Colors.white,
//                     alignment: Alignment.center,
//                     child: const Text(
//                       "Menu",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ))),
//           SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 1),
//               delegate:
//                   SliverChildBuilderDelegate((BuildContext context, int index) {
//                 index++;
//                 // return Container(
//                 //   padding: const EdgeInsets.all(10.0),
//                 //   decoration: BoxDecoration(
//                 //     color: Colors.blueGrey,
//                 //     borderRadius: BorderRadius.circular(10),
//                 //   ),
//                 //   child: Text("Item $index"),
//                 // );
//                 return Card(
//                   child: Column(
//                     children: <Widget>[

//                     ],
//                   ),
//                 );
//               }, childCount: 10))
//         ],
//       ),
//     );
//   }
// }

// class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   _StickyHeaderDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });

//   @override
//   double get minExtent => minHeight;

//   @override
//   double get maxExtent => maxHeight;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
//     return oldDelegate.minHeight != minHeight ||
//         oldDelegate.maxHeight != maxHeight ||
//         oldDelegate.child != child;
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlyu_cafe/model/menu_item.dart';
import 'package:onlyu_cafe/product_management/view_product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  final void Function(String) onButtonPressed;

  HomePage({super.key, required this.onButtonPressed});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _username = 'guest';
  String _role = '';
  List<MenuItem> menuItems = [];

  List<String> categories = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getUserData();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('Category').get();
      List<String> fetchedCategories =
          snapshot.docs.map((doc) => doc['name'] as String).toList();
      setState(() {
        categories = fetchedCategories;
      });
      if (categories.isNotEmpty) {
        _fetchMenuItems(categories[0]);
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  void _fetchMenuItems(String category) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('menu_items')
          .where('category', isEqualTo: category)
          .where('isAvailable', isEqualTo: true)
          .get();
      List<MenuItem> fetchedItems =
          snapshot.docs.map((doc) => MenuItem.fromDocument(doc)).toList();
      setState(() {
        menuItems = fetchedItems;
      });
    } catch (e) {
      print('Error fetching menu items: $e');
    }
  }

  Future<void> _getUserData() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final DocumentSnapshot userData =
          await _firestore.collection('User').doc(user.uid).get();

      if (userData.exists) {
        final String name = userData.get('name');
        final String role = userData.get('role');
        print('User name: $name');
        print('User role: $role');

        setState(() {
          _username = name;
        });
      } else {
        print('User data not found');
      }
    } else {
      setState(() {
        _username = 'guest';
        _role = '567';
      });
      print('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 220,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Welcome back, $_username!",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                  minHeight: 55,
                  maxHeight: 65,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const Text(
                      "Menu",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ))),
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      _fetchMenuItems(categories[selectedIndex]);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.only(
                          right: index == categories.length - 1 ? 0 : 10,
                          left: index == 0 ? 0 : 10,
                          top: 15),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? const Color(0xFFE5CAC3)
                            : Colors.transparent,
                        border: Border.all(
                          color: selectedIndex == index
                              ? Colors.transparent
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                              color: selectedIndex == index
                                  ? const Color(0xFF4B371C)
                                  : Colors.black,
                              fontWeight: selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: const Divider(),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7, // Adjust this value to set card size
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                MenuItem menuItem = menuItems[index];
                return Card(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewProductDetails(
                              item: menuItem,
                            ),
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (menuItem.imageUrl.isNotEmpty)
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(
                              menuItem.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 140, // Adjust the height as needed
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            menuItem.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\RM ${menuItem.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: menuItems.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
