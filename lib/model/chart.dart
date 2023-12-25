import 'package:flutter/material.dart';

class ChartDataModel {
  final String label;
  final String montant;
  final String pourcentage;
  final Color couleur;

  ChartDataModel({
    required this.label,
    required this.montant,
    required this.pourcentage,
    required this.couleur,
  });
}

final kChartData = [
  ChartDataModel(
    label: 'groceries',
    montant: '500.00',
    pourcentage: '24',
    couleur: Color.fromRGBO(82, 98, 255, 1),
  ),
  ChartDataModel(
    label: 'online Shopping',
    montant: '150.00',
    pourcentage: '15',
    couleur: Color.fromRGBO(46, 198, 255, 1),
  ),
  ChartDataModel(
    label: 'eating',
    montant: '90.00',
    pourcentage: '9',
    couleur: Color.fromRGBO(123, 201, 82, 1),
  ),
  ChartDataModel(
    label: 'bills',
    montant: '90.00',
    pourcentage: '9',
    couleur: Color.fromRGBO(255, 171, 67, 1),
  ),
  ChartDataModel(
    label: 'subscriptions',
    montant: '40.00',
    pourcentage: '4',
    couleur: Color.fromRGBO(252, 91, 57, 1),
  ),
  ChartDataModel(
    label: 'fees',
    montant: '20.00',
    pourcentage: '2',
    couleur: Color.fromRGBO(139, 135, 130, 1),
  ),
];

List<Map<String, dynamic>> getChartDataForCircularChart(
    List<ChartDataModel> data) {
  return data.map((item) {
    return {
      'x': item.label,
      'y': double.parse(item.pourcentage), // Convert to double
      'color': item.couleur,
    };
  }).toList();
}


  // factory ChartDataModel.fromJson(Map<String, dynamic> json) {
  //   return ChartDataModel(
  //     label: json['label'] ?? '',
  //     montant: json['montant'].toString(),
  //     pourcentage: json['pourcentage'] ?? '',
  //     couleur: getColorFromData(json['couleur']),
  //   );
  // }

  // static Color getColorFromData(String colorData) {
  //   if (colorData.isNotEmpty) {
  //     if (colorData.startsWith('#')) {
  //       colorData = colorData.substring(1);
  //     } else if (colorData.startsWith('0x')) {
  //       colorData = colorData.substring(2);
  //     }
  //     int? colorValue = int.tryParse(colorData, radix: 16);
  //     if (colorValue != null) {
  //       return Color(colorValue);
  //     }
  //   }
  //   return Colors.blue;
  // }

  // static String cleanAndFormatMontant(String montant) {
  //   // Remove spaces and commas from montant string
  //   return montant.replaceAll(RegExp(r'[, ]'), '');
  // }

