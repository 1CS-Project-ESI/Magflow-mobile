// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/product.dart';

// class ProductCard extends StatelessWidget {
//   final Product product;
//   final VoidCallback onAddToCart;

//   const ProductCard({
//     super.key,
//     required this.product,
//     required this.onAddToCart,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(product.name),
//         trailing: ElevatedButton(
//           onPressed: onAddToCart,
//           child: const Text('Add to Cart'),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          product.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: onAddToCart,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.green,
          ),
          child: Text('Add to Cart'),
        ),
      ),
    );
  }
}
