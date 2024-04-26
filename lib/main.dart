import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/home.dart';
import 'package:onlyu_cafe/user_management/firebase_options.dart';
import 'package:onlyu_cafe/user_management/profile.dart';
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
    const DoNothingPage(),
    const ProfilePage()
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

class DoNothingPage extends StatelessWidget {
  const DoNothingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 240, 238),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 229, 202, 195),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {},
      //   ),
      //   title: const Text("Do Nothing Page",
      //       style: TextStyle(
      //           fontSize: 20.0,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.black)),
      //   centerTitle: true,
      // ),
      body: Center(
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
