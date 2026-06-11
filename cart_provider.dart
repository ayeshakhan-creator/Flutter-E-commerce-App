import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  //ADD ITEM
  void addItem(String productId, String title, double price, String image) {
    if (_items.containsKey(productId)) {
      // increase quantity if already exists
      _items.update(
        productId,
            (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          image: existing.image,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
            () => CartItem(
          id: productId,
          title: title,
          price: price,
          image: image, //NEW
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  // ➕ increase quantity
  void increaseQty(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (item) => CartItem(
          id: item.id,
          title: item.title,
          price: item.price,
          image: item.image, //KEEP IMAGE
          quantity: item.quantity + 1,
        ),
      );
      notifyListeners();
    }
  }

  // ➖ decrease quantity
  void decreaseQty(String productId) {
    if (!_items.containsKey(productId)) return;

    final item = _items[productId]!;

    if (item.quantity > 1) {
      _items.update(
        productId,
            (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          image: existing.image,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
