import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlyu_cafe/home.dart';
import 'package:onlyu_cafe/login.dart';
import 'package:onlyu_cafe/service/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (nameController.text != "" &&
        emailController != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Registered Successfully",
          style: TextStyle(fontSize: 20.0),
        )));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          backgroundColor: Colors.orangeAccent;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            "Password entered is weak",
            style: TextStyle(fontSize: 20.0),
          )));
        } else if (e.code == "email-already-in-use") {
          backgroundColor: Colors.orangeAccent;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            "Email already exists",
            style: TextStyle(fontSize: 20.0),
          )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            // Validate the form
            if (_formkey.currentState!.validate()) {
              registration();
            }
          },
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Validate the form
                    if (_formkey.currentState!.validate()) {
                      registration();
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    AuthMethods().signInWithGoogle(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/google.jpg',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Sign Up with Google',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
