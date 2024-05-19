import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlyu_cafe/admin/admin_home.dart';
import 'package:onlyu_cafe/admin/admin_menu.dart';
import 'package:onlyu_cafe/admin/admin_setting.dart';
import 'package:onlyu_cafe/main.dart';
import 'package:onlyu_cafe/service/auth.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 229, 202, 195),
              // padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              await AuthMethods().signOut();
              runApp(const MyApp());
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          // HomePage(onButtonPressed: _navigateToMenu),
          // MenuPage(orderType: _orderType),
          // const ProfilePage(),
          AdminHomePage(),
          AdminMenuPage(),
          AdminSettingPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.menu_book), label: "Menu"),
          NavigationDestination(icon: Icon(Icons.settings), label: "More"),
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
