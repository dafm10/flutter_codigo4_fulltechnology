import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_sale_model.dart';

class ShoppingProvider extends ChangeNotifier {
  int _counter = 0;
  final List<ProductSaleModel> _products = [];

  int get counter => _counter;

  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  int get productLength => _products.length;

  List<ProductSaleModel> get getProduct => _products;

  addProduct(ProductSaleModel value) {
    _products.add(value);
    notifyListeners();
  }

  deleteProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  double get total {
    double totalFinal = 0;
    _products.forEach((element) {
      totalFinal = totalFinal + (element.price * element.quantity);
    });
    return totalFinal;
  }
}
