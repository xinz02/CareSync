import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/service/auth.dart';
import 'package:onlyu_cafe/user_management/forgot_password.dart';
import 'package:onlyu_cafe/user_management/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // context.go("/home");
      runApp(const MyApp());
      // Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "User does not exist",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Wrong password, please try again",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text('Login'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            height: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Login",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const Text(
            "Please sign in to continue.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 45, vertical: 10), //EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    // color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        // const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 20),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword()));
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(5, 0, 5, 0))),
                          child: const Text(
                            'Forgot Password?',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 195, 133, 134),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 125),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        userLogin();
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 3),
                  GestureDetector(
                    onTap: () {
                      AuthMethods().signInWithGoogle(context);
                    },
                    child: Container(
                      width: 290,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 195, 133, 134),
                      ),
                      // color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Google_icon.png',
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Sign In with Google',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              const SizedBox(
                width: 3,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(5, 0, 5, 0))),
                child: const Text(
                  "Create one",
                  style: TextStyle(color: Color.fromARGB(225, 70, 112, 219)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
