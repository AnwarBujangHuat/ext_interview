import 'package:ext_interview/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  String query = "";
  List<CartItem> results = [];

  void updateQuery(String newQuery) {
    query = newQuery;
    notifyListeners();
  }

  void search() {
    // Dummy search logic: filter by title
    results = [
      CartItem(
        title: 'Plant Care Package 1',
        subtitle: 'Premium plant care service',
        imagePath: 'assets/images/plant1.jpg',
        price: 85.0,
      ),
      CartItem(
        title: 'Plant Care Package 2',
        subtitle: 'Premium plant care service',
        imagePath: 'assets/images/plant2.jpg',
        price: 105.0,
      ),
    ].where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
    notifyListeners();
  }
}