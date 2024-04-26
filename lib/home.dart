import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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