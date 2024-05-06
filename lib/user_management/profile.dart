import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/router/router.dart';
import 'package:onlyu_cafe/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _username = '';
  String _email = '';
  String _phoneNum = '';

  @override
  void initState() {
    super.initState();
    if (isAuthenticated()) {
      _getUserData();
    }
  }

  Future<void> _getUserData() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final DocumentSnapshot userData =
          await _firestore.collection('User').doc(user.uid).get();

      if (userData.exists) {
        final String name = userData.get('name');
        final String email = userData.get('email');
        final String phoneNum = userData.get('phoneNumber') ?? '';
        setState(() {
          // Update the _username variable
          _username = name;
          _email = email;
          _phoneNum = phoneNum;
        });
      } else {
        print('User data not found');
      }
    } else {
      setState(() {
        // Update the _username variable
        _username = 'guest';
        _email = 'guest@gmail.com';
        _phoneNum = '0123456789';
      });
      print('User not logged in');
    }
  }

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
            const Icon(
              Icons.person,
              size: 72,
            ),

          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  'Personal Details',
                  style: TextStyle(
                      color: Color(0xFF4B371C), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          MyTextBox(
            text: _username, //currentUser!.displayName ?? 'N/A',
            sectionName: 'Name',
            editable: false, // Make it editable
            // onPressed: () => editField(context, 'name'),
          ),

          const SizedBox(height: 10),
          MyTextBox(
            text: _email, //currentUser!.email ?? 'N/A',
            sectionName: 'Email',
            editable: false, // Make it read-only
          ),

          const SizedBox(height: 10),
          MyTextBox(
            text: _phoneNum, // Update with actual phone number
            sectionName: 'Phone',
            editable: true, // Make it editable
            onPressed: () => _editPhone(context), //editField(context, 'Phone'),
          ),
          const SizedBox(
            height: 15,
          ),
          _auth.currentUser != null
              ? Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await AuthMethods().signOut();
                        runApp(const MyApp());
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  void _editPhone(BuildContext context) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    String newPhone = _phoneNum;

    // Show an alert dialog for editing the phone number
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Phone Number'),
        content: TextField(
          onChanged: (value) => newPhone = value,
          decoration: const InputDecoration(
            hintText: 'Enter new phone number',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Only update if a new phone number is provided
              if (newPhone.isNotEmpty && newPhone != _phoneNum) {
                try {
                  // Update Firestore with the new phone number
                  await FirebaseFirestore.instance
                      .collection('User')
                      .doc(user.uid)
                      .update({'phoneNumber': newPhone});

                  setState(() {
                    _phoneNum = newPhone;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Phone number updated successfully')),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Failed to update phone number: $error')),
                  );
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
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
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.all(10),
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
              const SizedBox(height: 5),
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
              icon: const Icon(Icons.edit),
              color: Colors.grey[400],
            ),
        ],
      ),
    );
  }
}
