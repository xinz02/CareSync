import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:onlyu_cafe/model/cart_item.dart';
import 'package:onlyu_cafe/model/order.dart' as MyOrder;

class OrderDetailsPage extends StatefulWidget {
  final String userId;

   OrderDetailsPage({required this.userId, required MyOrder.Order order, required String orderId});

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _orderStream;

  @override
  void initState() {
    super.initState();
    _orderStream = FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.userId) // Assuming 'id' is the document ID of the order
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _orderStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No order found.'));
          } else {
            Map<String, dynamic> orderData = snapshot.data!.data()!;
            List<dynamic> cartList = orderData['cartList'];

            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> cartItem = cartList[index];
                CartItem item = CartItem.fromMap(cartItem);

                return ListTile(
                  title: Text(item.menuItem.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  // Add more information here if needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
