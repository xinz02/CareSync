import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:onlyu_cafe/service/auth.dart';
import 'package:onlyu_cafe/user_management/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onlyu_cafe/user_management/signup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _doNothing() {}
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _username = 'guest';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final DocumentSnapshot userData =
          await _firestore.collection('User').doc(user.uid).get();

      if (userData.exists) {
        final String name = userData.get('name');
        setState(() {
          // Update the _username variable
          _username = name;
        });
      } else {
        print('User data not found');
      }
    } else {
      print('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      // body: Center(child: Text("Home Page")),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 220,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: _doNothing,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 246, 231, 232),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 52),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            "Dine In",
                            style: TextStyle(fontSize: 16),
                          )),
                      ElevatedButton(
                          onPressed: _doNothing,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 246, 231, 232),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 52),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            "Pick Up",
                            style: TextStyle(fontSize: 16),
                          )),
                      // ElevatedButton(
                      //     onPressed: _doNothing, child: const Text("Button3")),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                  //logout - will be remove after this
                  _auth.currentUser != null
                      ? Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                AuthMethods().signOut();
                                context.go("/main");
                              },
                              child: const Text("Logout"),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                  minHeight: 55,
                  maxHeight: 70,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const Text(
                      "Menu",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ))),
          SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                index++;
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Item $index"),
                );
              }, childCount: 10))
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
