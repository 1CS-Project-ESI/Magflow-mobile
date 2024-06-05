

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/product.dart';

class CartProvider with ChangeNotifier {
  List<Product> _products = [];
  final Map<Product, int> _productQuantities = {};

  List<Product> get products => _products;

  void addProduct(Product product) {
    if (_productQuantities.containsKey(product)) {
      _productQuantities[product] = _productQuantities[product]! + 1;
    } else {
      _productQuantities[product] = 1;
      _products.add(product);
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_productQuantities.containsKey(product)) {
      if (_productQuantities[product]! > 1) {
        _productQuantities[product] = _productQuantities[product]! - 1;
      } else {
        _productQuantities.remove(product);
        _products.remove(product);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _products.clear();
    _productQuantities.clear();
    notifyListeners();
  }

  int getProductQuantity(Product product) {
    return _productQuantities[product] ?? 0;
  }
}
