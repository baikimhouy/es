import 'package:flutter/material.dart';
import '../../../../data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _items = [];

  List<ProductModel> get items => List.unmodifiable(_items);
  int get count => _items.length;

  void add(ProductModel p) {
    _items.add(p);
    notifyListeners();
  }

  void remove(ProductModel p) {
    _items.remove(p);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  bool contains(ProductModel p) => _items.contains(p);
}