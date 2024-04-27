import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/service/auth.dart';

bool isAuthenticated() {
  // Check if there's a user logged in
  return FirebaseAuth.instance.currentUser != null;
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  bool isAuthenticated() {
    // Check if there's a user logged in
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Profile Page"),
            isAuthenticated()
                ? ElevatedButton(
                    onPressed: () async {
                      await AuthMethods().signOut();
                      runApp(MyApp());
                    },
                    child: const Text("Logout"),
                  )
                : ElevatedButton(
                    onPressed: () {
                      context.push("/signup");
                    },
                    child: const Text("Sign Up"),
                  )
          ],
        ),
      ),
    );
  }
}
