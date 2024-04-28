// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_super_parameters, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/home.dart';
import 'package:onlyu_cafe/user_management/firebase_options.dart';
import 'package:onlyu_cafe/router/router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = goRouter();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Only U Cafe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 248, 240, 238),
        ),
        useMaterial3: true,
      ),
    );
  }
}

class NavigationBarExample extends StatefulWidget {
  const NavigationBarExample({super.key});

  @override
  NavigationBarExampleState createState() => NavigationBarExampleState();
}

class NavigationBarExampleState extends State<NavigationBarExample> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const MenuPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Only U Cafe',
          style: GoogleFonts.kaushanScript(),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 229, 202, 195),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.menu_book), label: "Menu"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        indicatorColor: const Color.fromARGB(255, 229, 202, 195),
        animationDuration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.white10,
        shadowColor: Colors.white30,
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

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

class ProfilePage extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          // Display user's profile image if available
          if (currentUser!.photoURL != null)
            Image.network(
              currentUser!.photoURL!,
              width: 72,
              height: 72,
            )
          else
            // Show person icon if profile image URL is null
            Icon(
              Icons.person,
              size: 72,
            ),
          
          const SizedBox(height: 10),
          Text(
            currentUser?.displayName ?? '', 
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey), 
          ),
          
          const SizedBox(height: 10),
          ListTile(
            title: Text(
              'Email',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              currentUser?.email ?? 'N/A',
              style: TextStyle(fontSize: 18),
            ),
            trailing: IconButton(
              onPressed: () => _editEmail(context),
              icon: Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  // Method to handle editing email
  void _editEmail(BuildContext context) async {
    String newEmail = '';

    // Show an alert dialog for editing email
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Email'),
        content: TextField(
          onChanged: (value) => newEmail = value,
          decoration: InputDecoration(
            hintText: 'Enter new email',
          ),
=======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser?.email)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final userData = snapshot.data?.data() as Map<String, dynamic>?;

            if (userData != null) {
              return ListView(
                children: [
                  const SizedBox(height: 50),
                  // Display user's profile image if available
                  if (currentUser!.photoURL != null)
                    Image.network(
                      currentUser!.photoURL!,
                      width: 72,
                      height: 72,
                    )
                  else
                    // Show person icon if profile image URL is null
                    Icon(
                      Icons.person,
                      size: 72,
                    ),

                  const SizedBox(height: 10),
                  Text(
                    currentUser!.displayName ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 50),
                  MyTextBox(
                    text: userData['name'],
                    sectionName: 'Email',
                    onPressed: () => editField(context, 'Email'),
                  )
                ],
              );
            } else {
              // Handle case where snapshot data is null
              return Center(
                child: Text('No data available'),
              );
            }
          }
        },
      ),
    );
  }
}

class MyTextBox extends StatelessWidget {
  final String? text;
  final String sectionName;
  final VoidCallback onPressed;

  const MyTextBox({
    Key? key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sectionName),
            Text(text ?? 'N/A'),
          ],
>>>>>>> 226a4f20af04edd81cb2ba79d6a1542cc4fa88b3
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Update email if not empty
              if (newEmail.isNotEmpty) {
                try {
                  await currentUser!.updateEmail(newEmail);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Email updated successfully')),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update email: $error')),
                  );
                }
              }
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
// class ProfilePage extends StatelessWidget {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   @override
//   Widget build(BuildContext context) {
//     print("Current user email: ${currentUser?.email}");

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 248, 240, 238),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance
//             .collection('User')
//             .doc(currentUser?.email)
//             .get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             print("Error retrieving data: ${snapshot.error}");
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             final userData = snapshot.data?.data() as Map<String, dynamic>?;

//             if (userData != null) {
//               print("User data: $userData");
//               return ListView(
//                 children: [
//                   const SizedBox(height: 50),
//                   // Display user's profile image if available
//                   if (currentUser!.photoURL != null)
//                     Image.network(
//                       currentUser!.photoURL!,
//                       width: 72,
//                       height: 72,
//                     )
//                   else
//                     // Show person icon if profile image URL is null
//                     Icon(
//                       Icons.person,
//                       size: 72,
//                     ),

//                   const SizedBox(height: 10),
//                   Text(
//                     currentUser!.displayName ?? '',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.grey),
//                   ),

//                   const SizedBox(height: 50),
//                   MyTextBox(
//                     text: userData['name'],
//                     sectionName: 'Email',
//                     onPressed: () => editField(context, 'Email'),
//                   )
//                 ],
//               );
//             } else {
//               // Handle case where snapshot data is null
//               print("No user data found");
//               return Center(
//                 child: Text('No data available'),
//               );
//             }
//           }
//         },
//       ),
//     );
//   }

//   Future<void> editField(BuildContext context, String field) async {
//     String newValue = '';
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.grey[900],
//         title: Text(
//           'Edit $field',
//           style: const TextStyle(color: Colors.white),
//         ),
//         content: TextField(
//           autofocus: true,
//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             hintText: 'Enter new $field',
//             hintStyle: TextStyle(color: Colors.grey),
//           ),
//           onChanged: (value) {
//             newValue = value;
//           },
//         ),
//         actions: [
//           TextButton(
//             child: Text('Cancel', style: TextStyle(color: Colors.white)),
//             onPressed: () => Navigator.pop(context),
//           ),
//           TextButton(
//             child: Text('Save', style: TextStyle(color: Colors.white)),
//             onPressed: () => Navigator.of(context).pop(newValue),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyTextBox extends StatelessWidget {
//   final String? text;
//   final String sectionName;
//   final VoidCallback onPressed;

//   const MyTextBox({
//     Key? key,
//     required this.text,
//     required this.sectionName,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(sectionName),
//             Text(text ?? 'N/A'),
//           ],
//         ),
//       ),
//     );
//   }
// }