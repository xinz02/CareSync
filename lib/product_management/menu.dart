import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  final String orderType;
  const MenuPage({super.key, this.orderType = ''});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
      List<String> fetchedCategories =
          snapshot.docs.map((doc) => doc['name'] as String).toList();
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
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 25),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: searchController,
                  style: const TextStyle(color: Color(0xFFB1A6A6)),
                  decoration: InputDecoration(
                    hintText: 'Hunt for your daily delight!',
                    hintStyle: const TextStyle(color: Color(0xFFB1A6A6)),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    filterCategories(value);
                  },
                ),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 25),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.only(
                            right: index == categories.length - 1 ? 0 : 10,
                            left: index == 0 ? 0 : 10,
                            top: 15),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? const Color(0xFFE5CAC3)
                              : Colors.transparent,
                          border: Border.all(
                            color: selectedIndex == index
                                ? Colors.transparent
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                                color: selectedIndex == index
                                    ? const Color(0xFF4B371C)
                                    : Colors.black,
                                fontWeight: selectedIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 5), // Add horizontal and vertical margin here
                child: const Divider(),
              ), // Add the Divider widget here
              Expanded(
                child: Center(
                  child: Text(
                    'Selected: ${categories[selectedIndex]}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ],
          );
  }
}
