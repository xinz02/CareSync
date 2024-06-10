import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminOrderDetailsPage extends StatefulWidget {
  final DocumentSnapshot order;

  const AdminOrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  _AdminOrderDetailsPageState createState() => _AdminOrderDetailsPageState();
}

class _AdminOrderDetailsPageState extends State<AdminOrderDetailsPage> {
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.order['status'];
  }

  @override
  Widget build(BuildContext context) {
    final items = List<Map<String, dynamic>>.from(widget.order['items']);
    final orderTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.order['timestamp'].toDate());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${widget.order.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items: ['Paid', 'Preparing', 'Ready'].map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateOrderStatus(_selectedStatus);
              },
              child: const Text('Update Order Status'),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Time: $orderTime',
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text('Status: $_selectedStatus', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Text('Option: ${widget.order['option']}'),
            if (widget.order['option'] == 'Pickup') Text('Pickup Time: ${widget.order['pickupTime']}'),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(item['imageUrl']),
                      title: Text(item['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Category: ${item['category']}'),
                          Text('Description: ${item['description']}'),
                          Text('Quantity: ${item['quantity']}'),
                          Text('Price: \$${item['price'].toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Total Amount: \$${widget.order['totalAmount'].toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Future<void> _updateOrderStatus(String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.order.id)
          .update({'status': newStatus});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order status updated successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update order status: $error')),
      );
    }
  }
}
