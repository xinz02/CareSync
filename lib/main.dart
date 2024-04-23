import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/user_management/firebase_options.dart';
import 'package:onlyu_cafe/router/router.dart';

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

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 202, 195),
        title: const Text("Home Page",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  context.push("/donothing");
                },
                child: const Text("DoNothing")),
            ElevatedButton(
                onPressed: () {
                  context.push("/cart");
                },
                child: const Text("Cart")),
            ElevatedButton(
                onPressed: () {
                  context.push("/signup");
                },
                child: const Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}

class DoNothingPage extends StatelessWidget {
  const DoNothingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 202, 195),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Do Nothing Page",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Do Nothing Page',
            ),
          ],
        ),
      ),
    );
  }
}
