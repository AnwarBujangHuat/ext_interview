import 'package:flutter/material.dart';
class CartItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final double price;
  int quantity;
   int stock;

  CartItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
     this.stock=0,
  });
}

class CartViewModel extends ChangeNotifier {
  List<CartItem> cartItems = [];

  void addItem(CartItem item) {
    final index = cartItems.indexWhere((e) => e.title == item.title);
    if (index != -1) {
      // Already in cart, check stock before increment
      if (cartItems[index].quantity < cartItems[index].stock) {
        cartItems[index].quantity++;
        notifyListeners();
      }
    } else {
      cartItems.add(item);
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    if (cartItems[index].quantity < cartItems[index].stock) {
      cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    cartItems[index].quantity--;
    if (cartItems[index].quantity <= 0) {
      cartItems.removeAt(index);
    }
    notifyListeners();
  }

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }
}