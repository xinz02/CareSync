import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/main.dart';
// import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/service/auth.dart';
import 'package:onlyu_cafe/user_management/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
<<<<<<<<< Temporary merge branch 1
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _username = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final DocumentSnapshot userData = await _firestore
          .collection('User')
          .doc(user.uid)
          .get();

      if (userData.exists) {
        final String name = userData.get('name');
        setState(() { // Update the _username variable
          _username = name;
        });
      } else {
        print('User data not found');
      }
    } else {
      print('User not logged in');
    }
  }
=========
  void _doNothing() {}
>>>>>>>>> Temporary merge branch 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<<<< Temporary merge branch 1
      backgroundColor: Color.fromARGB(255, 248, 240, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _auth.currentUser == null
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
                    },
                    child: Text("Sign Up/Login"),
                  )
                : Container(),
            SizedBox(height: 20),
            _auth.currentUser != null
                ? Column(
                    children: [
                      Text("Hello, $_username"), 
                      ElevatedButton(
                        onPressed: () async {
                          AuthMethods().signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: Text("Logout"),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
=========
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      // body: Center(child: Text("Home Page")),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: _doNothing, child: const Text("Button1")),
                  ElevatedButton(
                      onPressed: _doNothing, child: const Text("Button2")),
                  ElevatedButton(
                      onPressed: _doNothing, child: const Text("Button3")),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                  minHeight: 60,
                  maxHeight: 75,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const Text(
                      "Test Menu",
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
                  padding: const EdgeInsets.all(8.0),
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
>>>>>>>>> Temporary merge branch 2
