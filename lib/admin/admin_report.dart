import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onlyu_cafe/product_management/add_menu_item.dart';
import 'admin_order.dart';
import 'admin_category.dart';
import 'admin_main.dart';

class AdminReportPage extends StatefulWidget {
  const AdminReportPage({Key? key}) : super(key: key);

  @override
  _AdminReportPageState createState() => _AdminReportPageState();
}

class _AdminReportPageState extends State<AdminReportPage> {
  int totalOrders = 0;
  int totalOrdersToday = 0;
  int totalCategories = 0;
  int totalItems = 0;
  double totalRevenue = 0.0;
  double totalRevenueToday = 0.0;
  String selectedFilter = 'All Time';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await fetchOrdersCount();
    await fetchCategoriesCount();
    await fetchItemsCount();
    await fetchOrdersForTimeFrame(selectedFilter);
    setState(() {});
  }

  Future<void> fetchOrdersCount() async {
    final ordersSnapshot = await FirebaseFirestore.instance.collection('orders').get();
    totalOrders = ordersSnapshot.size;
  }

  Future<void> fetchCategoriesCount() async {
    final categoriesSnapshot = await FirebaseFirestore.instance.collection('Category').get();
    totalCategories = categoriesSnapshot.size;
  }

  Future<void> fetchItemsCount() async {
    final itemsSnapshot = await FirebaseFirestore.instance.collection('menu_items').get();
    totalItems = itemsSnapshot.size;
  }

  Future<void> fetchOrdersForTimeFrame(String filter) async {
    final now = DateTime.now();
    DateTime startOfDay;
    DateTime startOfWeek;
    DateTime startOfMonth;
    DateTime startOfTimeFrame;

    startOfDay = DateTime(now.year, now.month, now.day);
    startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    startOfMonth = DateTime(now.year, now.month, 1);

    switch (filter) {
      case 'Today':
        startOfTimeFrame = startOfDay;
        break;
      case 'This Week':
        startOfTimeFrame = startOfWeek;
        break;
      case 'This Month':
        startOfTimeFrame = startOfMonth;
        break;
      default:
        startOfTimeFrame = DateTime(2000);
    }

    final ordersSnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('timestamp', isGreaterThanOrEqualTo: startOfTimeFrame)
        .get();

    int ordersCount = ordersSnapshot.size;
    double revenue = 0.0;

    for (var doc in ordersSnapshot.docs) {
      revenue += doc['totalAmount'];
    }

    setState(() {
      if (filter == 'Today') {
        totalOrdersToday = ordersCount;
        totalRevenueToday = revenue;
      } else {
        totalOrders = ordersCount;
        totalRevenue = revenue;
      }
      selectedFilter = filter;
    });
  }

  Widget _buildFilterButton(String text, String filter) {
    return ElevatedButton(
      onPressed: () {
        fetchOrdersForTimeFrame(filter);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedFilter == filter ? const Color.fromARGB(255, 195, 133, 134) : null, // Highlight selected button
      ),
      child: Text(text),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 40.0),
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 18.0),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final adminMainPageState = context.findAncestorStateOfType<AdminMainPageState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: [
                  _buildFilterButton('All Time', 'All Time'),
                  _buildFilterButton('Today', 'Today'),
                  _buildFilterButton('This Week', 'This Week'),
                  _buildFilterButton('This Month', 'This Month'),
                ],
              ),
              SizedBox(height: 20),
              _buildStatCard(
                'Total Orders',
                selectedFilter == 'All Time' ? '$totalOrders' : (selectedFilter == 'Today' ? '$totalOrdersToday' : '$totalOrders'),
                Icons.shopping_cart,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminOrderPage()),
                  );
                },
              ),
              _buildStatCard(
                'Total Revenue',
                selectedFilter == 'All Time' ? '\$${totalRevenue.toStringAsFixed(2)}' : (selectedFilter == 'Today' ? '\$${totalRevenueToday.toStringAsFixed(2)}' : '\$${totalRevenue.toStringAsFixed(2)}'),
                Icons.attach_money,
                () {
                  // No action needed for revenue stat card
                },
              ),
              SizedBox(height: 20),
              Text(
                'Additional Information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              _buildStatCard(
                'Total Categories',
                '$totalCategories',
                Icons.category,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminCategoryPage()),
                  );
                },
              ),
              _buildStatCard(
                'Total Items',
                '$totalItems',
                Icons.fastfood,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddMenuItemPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
