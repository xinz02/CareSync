class MenuItem {
  String id;
  String name;
  String description;
  double price;
  String imageUrl;
  bool isAvailable;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isAvailable,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
    };
  }

  // Create a MenuItem from a Map (e.g., from Firestore)
  static MenuItem fromMap(Map<String, dynamic> map, String item_Id) {
    return MenuItem(
      id: item_Id,
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      isAvailable: map['isAvailable'],
    );
  }
}
