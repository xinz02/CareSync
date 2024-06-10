import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailsPage extends StatelessWidget {
  final DocumentSnapshot order;

  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = List<Map<String, dynamic>>.from(order['items']);
    final orderTime = TimeOfDay.fromDateTime(order['timestamp'].toDate()).format(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Order Status: ${order['status']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Order Time: $orderTime'),
            Text('Option: ${order['option']}'),
            if (order['option'] == 'Pickup') Text('Pickup Time: ${order['pickupTime']}'),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final price = double.parse(item['price'].toString()).toStringAsFixed(2);
                  return Card(
                    child: ListTile(
                      leading: Image.network(item['imageUrl'] as String),
                      title: Text(item['name'] as String),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Category: ${item['category']}'),
                          Text('Description: ${item['description']}'),
                          Text('Quantity: ${item['quantity']}'),
                          Text('Price: \$$price'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Total Amount: \$${double.parse(order['totalAmount'].toString()).toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (order['status'] == 'Ready') 
              ElevatedButton(
                onPressed: () {
                  // Handle rating functionality
                },
                child: const Text('Rate'),
              ),
          ],
        ),
      ),
    );
  }
}
