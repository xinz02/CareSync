// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unnecessary_import, unused_import, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/home.dart';
import 'package:onlyu_cafe/product_management/menu.dart';
import 'package:onlyu_cafe/user_management/firebase_options.dart';
import 'package:onlyu_cafe/user_management/login.dart';
import 'package:onlyu_cafe/user_management/profile.dart';
import 'package:onlyu_cafe/menu_management/category.dart';
import 'package:onlyu_cafe/router/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

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
      // routerConfig: goRouter,
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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String _orderType = '';

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2 && !isAuthenticated()) {
        context.go("/login");
      }
      _selectedIndex = index;
    });
  }

  void _navigateToMenu(String orderType) {
    setState(() {
      _selectedIndex = 1; // Switch to the Menu tab
      _orderType = orderType; // Set the order type
    });
  }

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
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                if (!isAuthenticated()) {
                  context.go("/login");
                } else {
                  context.push("/cart");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 229, 202, 195),
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
              ),
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -10, end: -10),
                badgeContent: const Text(
                  "23",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
                child: const Icon(Icons.shopping_cart),
              )),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(onButtonPressed: _navigateToMenu),
          MenuPage(orderType: _orderType),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.menu_book), label: "Menu"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        indicatorColor: const Color.fromARGB(255, 229, 202, 195),
        animationDuration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.white10,
        shadowColor: Colors.white30,
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  final String orderType;
  const MenuPage({this.orderType = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      body: Center(
        // child: Text("Menu Page"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Menu Page"),
            Text("Order Type: $orderType"),
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

// class MainPage extends StatefulWidget {
//   final int tab;
//   const MainPage({super.key, this.tab = 0});

//   @override
//   // _MainPageState createState() => _MainPageState();
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = widget.tab;
//     print("init selected tab: $selectedIndex");
//   }

//   void _onDestinationSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//       print("onDestination selected: $selectedIndex");
//       if (selectedIndex == 2 && !isAuthenticated()) {
//         context.push("/login");
//         // Login();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget getBodyWidget(int index) {
//       print("Selected tab in build: $index");
//       switch (index) {
//         case 0:
//           int test = widget.tab;
//           print("widget.tab : $test");
//           return const HomePage();
//         case 1:
//           int test = widget.tab;
//           print("widget.tab : $test");
//           return const MenuPage();
//         case 2:
//           int test = widget.tab;
//           print("widget.tab : $test");
//           return ProfilePage();
//         default:
//           int test = widget.tab;
//           print("widget.tab : $test");
//           return const HomePage();
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Only U Cafe',
//           style: GoogleFonts.kaushanScript(),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 229, 202, 195),
//       ),
//       body: getBodyWidget(selectedIndex),
//       // _pages[_selectedIndex],
//       bottomNavigationBar: NavigationBar(
//         destinations: const [
//           NavigationDestination(icon: Icon(Icons.home), label: "Home"),
//           NavigationDestination(icon: Icon(Icons.menu_book), label: "Menu"),
//           NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
//         ],
//         selectedIndex: selectedIndex,
//         onDestinationSelected: _onDestinationSelected,
//         indicatorColor: const Color.fromARGB(255, 229, 202, 195),
//         animationDuration: const Duration(milliseconds: 1000),
//         backgroundColor: Colors.white10,
//         shadowColor: Colors.white30,
//       ),
//     );
//   }
// }
