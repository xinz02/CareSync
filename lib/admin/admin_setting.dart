import 'package:flutter/material.dart';
import 'package:onlyu_cafe/product_management/add_menu_item.dart';

class AdminSettingPage extends StatelessWidget {
  const AdminSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 240, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin Setting Page',
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      AddMenuItemPage(), // Replace OrderPage with your actual order page
                ),
              ),
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
