// lib/models/product.dart
class Product {
  final int id;
  final String name;
  // final String caracteristics;

  Product({required this.id, required this.name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      // caracteristics: json['caracteristics'],
    );
  }



  
}

// lib/models/cart_item.dart

