// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryMenu extends StatefulWidget {
  @override
  _CategoryMenuState createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> categories = [];
  int selectedIndex = 0;
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('Category').get();
      List<String> fetchedCategories = snapshot.docs.map((doc) => doc['name'] as String).toList();
      setState(() {
        categories = fetchedCategories;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterCategories(String query) {
    List<String> filteredList = categories.where((category) {
      return category.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      var filteredCategories = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 25),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: searchController,
                  style: TextStyle(color: Color(0xFFB1A6A6)),
                  decoration: InputDecoration(
                    hintText: 'Hunt for your daily delight!',
                    hintStyle: TextStyle(color: Color(0xFFB1A6A6)),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    filterCategories(value);
                  },
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.only(right: index == categories.length - 1 ? 0 : 10, left: index == 0 ? 0 : 10, top: 15), 
                        decoration: BoxDecoration(
                          color: selectedIndex == index ? Color(0xFFE5CAC3) : Colors.transparent,
                          border: Border.all(
                            color: selectedIndex == index ? Colors.transparent : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: selectedIndex == index ? Color(0xFF4B371C) : Colors.black,
                              fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.w400,
                              fontSize: 15
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5), // Add horizontal and vertical margin here
                child: Divider(),
              ),// Add the Divider widget here
              Expanded(
                child: Center(
                  child: Text(
                    'Selected: ${categories[selectedIndex]}',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          );
  }
}
