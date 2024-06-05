// cart.dart
import 'package:flutter_application_1/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  final List<CartItem> items = [];

  void addProduct(Product product) {
    for (var item in items) {
      if (item.product.id == product.id) {
        item.quantity++;
        return;
      }
    }
    items.add(CartItem(product: product));
  }

  void removeProduct(Product product) {
    items.removeWhere((item) => item.product.id == product.id);
  }

  void updateQuantity(Product product, int quantity) {
    for (var item in items) {
      if (item.product.id == product.id) {
        item.quantity = quantity;
        return;
      }
    }
  }

  void clear() {
    items.clear();
  }
}
