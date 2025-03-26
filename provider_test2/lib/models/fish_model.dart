import 'package:flutter/material.dart';

class FishModel with ChangeNotifier {
  final String name;
  int count;
  final String size;

  FishModel({required this.name, required this.count, required this.size});

  void increaseCount() {
    count++;
    notifyListeners();
  }
}
