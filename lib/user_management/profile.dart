import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return const Scaffold(
  //     backgroundColor: Color.fromARGB(255, 248, 240, 238),
  //     // appBar: AppBar(
  //     //   backgroundColor: const Color.fromARGB(255, 229, 202, 195),
  //     //   leading: IconButton(
  //     //     icon: const Icon(Icons.arrow_back),
  //     //     onPressed: () {},
  //     //   ),
  //     //   title: const Text("Do Nothing Page",
  //     //       style: TextStyle(
  //     //           fontSize: 20.0,
  //     //           fontWeight: FontWeight.bold,
  //     //           color: Colors.black)),
  //     //   centerTitle: true,
  //     // ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             'Profile Page',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      body: Center(
        // child: Text("Menu Page"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
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
