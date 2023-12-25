import 'package:flutter/material.dart';

class Category {
  final String name;
  final double amount;
  Category({required this.name, required this.amount});
}

final kCategories = [
  Category(name: 'groceries', amount: 500.00),
  Category(name: 'online Shopping', amount: 150.00),
  Category(name: 'eating', amount: 90.00),
  Category(name: 'bills', amount: 90.00),
  Category(name: 'subscriptions', amount: 40.00),
  Category(name: 'fees', amount: 20.00),
];

final kNeumorphicColors = [
  Color.fromRGBO(82, 98, 255, 1), //  rgb(82, 98, 255)
  Color.fromRGBO(46, 198, 255, 1), // rgb(46, 198, 255)
  Color.fromRGBO(123, 201, 82, 1), // rgb(123, 201, 82)
  Color.fromRGBO(255, 171, 67, 1), // rgb(255, 171, 67)
  Color.fromRGBO(252, 91, 57, 1), //  rgb(252, 91, 57)
  Color.fromRGBO(139, 135, 130, 1), //rgb(139, 135, 130)
];
