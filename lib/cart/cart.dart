import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onlyu_cafe/model/cart_item.dart';
import 'package:onlyu_cafe/service/cart_service.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService cartService = CartService();
  List<CartItem> cartItems = [];
  bool isLoading = true;
  String? errorMessage;
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  void _fetchCartItems() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      List<CartItem> items = await cartService.getCartList();
      setState(() {
        cartItems = items;
        isLoading = false;
        _calculateTotalPrice();
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  void _updateQuantity(String itemId, int newQuantity) async {
    try {
      await cartService.updateItemQuantity(itemId, newQuantity);
      _fetchCartItems();
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  double _calculateSubtotal(double price, int quantity) {
    return price * quantity;
  }

  void _calculateTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += _calculateSubtotal(item.menuItem.price, item.quantity);
    }
    setState(() {
      totalPrice = total;
    });
  }

  void _showRemoveItemDialog(String itemId, int newQuantity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Remove Cart Item"),
          content: const Text('Do you want to remove this cart item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _updateQuantity(itemId, newQuantity);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 240, 238),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 202, 195),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Your Cart",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage != null
              ? Center(
                  child: Text('Error: $errorMessage'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          double subtotal = _calculateSubtotal(
                            cartItems[index].menuItem.price,
                            cartItems[index].quantity,
                          );
                          return Card(
                            color: Colors.white,
                            elevation: 0,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListTile(
                              leading:
                                  cartItems[index].menuItem.imageUrl.isNotEmpty
                                      ? Image.network(
                                          cartItems[index].menuItem.imageUrl,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover)
                                      : Icon(Icons.image),
                              title: Text(
                                cartItems[index].menuItem.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Row(
                                children: [
                                  IconButton(
                                    color: Color.fromARGB(255, 195, 133, 134),
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      int newQuantity =
                                          cartItems[index].quantity - 1;
                                      if (newQuantity < 1) {
                                        _showRemoveItemDialog(
                                            cartItems[index].menuItem.id,
                                            newQuantity);
                                      } else {
                                        _updateQuantity(
                                            cartItems[index].menuItem.id,
                                            newQuantity);
                                      }
                                    },
                                  ),
                                  Text('${cartItems[index].quantity}'),
                                  IconButton(
                                    color: Color.fromARGB(255, 195, 133, 134),
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      int newQuantity =
                                          cartItems[index].quantity + 1;
                                      _updateQuantity(
                                          cartItems[index].menuItem.id,
                                          newQuantity);
                                    },
                                  ),
                                ],
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'RM${subtotal.toStringAsFixed(2)}',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'RM${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context.push("/checkout");
                              },
                              child: Text("Checkout")),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
