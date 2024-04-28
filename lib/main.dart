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
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 30),
                Text (
                  'Personal Details',
                  style: TextStyle(
                    color: Color(0xFF4B371C),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          MyTextBox(
            text: currentUser!.displayName ?? 'N/A',
            sectionName: 'Name',
            editable: false,
          ),

          const SizedBox(height: 10),
          MyTextBox(
            text: currentUser!.email ?? 'N/A',
            sectionName: 'Email',
            editable: false, // Make it read-only
          ),
          
          const SizedBox(height: 10),
          MyTextBox(
            text: '0123456486', // Update with actual phone number
            sectionName: 'Phone Number',
            editable: true, // Make it editable
            onPressed: () => editField(context, 'phone'),
          ),
        ],
      ),
    );
  }

  Future<void> editField(BuildContext context, String field) async {
  String? newValue;
  newValue = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Edit $field',
        style: const TextStyle(color: Colors.black),
      ),
      content: TextField(
        autofocus: true,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Enter new $field',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onChanged: (value) {
          newValue = value;
        },
      ),
      actions: [
        TextButton(
          child: Text('Cancel', style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Save', style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.of(context).pop(newValue),
        ),
      ],
    ),
  );

  if (newValue != null && newValue!.isNotEmpty) {
    // Update value in Firebase
    if (field == 'name') {
      await currentUser!.updateDisplayName(newValue!);
    } else if (field == 'phone') {
      // Update phone number in Firestore (replace this with your Firestore update logic)
    }
    
    // Update UI with new value
    // // setState(() {
    //   if (field == 'phone') {
    //     // Update phone number
    //     // currentUser!.phoneNumber = newValue;
    //   }
    // });
  }
 }
}

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final VoidCallback? onPressed;
  final bool editable; // New parameter to control editability

  const MyTextBox({
    Key? key,
    required this.text,
    required this.sectionName,
    this.onPressed,
    this.editable = true, // Default to true for editable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: Colors.grey), // Add a horizontal line under the section name
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                  color: editable ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
          if (onPressed != null && editable)
            IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.edit),
              color: Colors.grey[400],
            ),
        ],
      ),
    );
  }
}