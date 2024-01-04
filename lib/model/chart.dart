import 'dart:ui';

class ChartDataOne {
  final String label;
  final double litres;
  final double totale;

  ChartDataOne({
    required this.label,
    required this.litres,
    required this.totale,
  });
  factory ChartDataOne.fromJson(Map<String, dynamic> json) {
    return ChartDataOne(
      label: json['type'],
      litres: json['litres'],
      totale: json['totale'],
    );
  }
}

final kNeumorphicColorsPieOne = [
  Color.fromRGBO(82, 98, 255, 1), //  rgb(82, 98, 255)
  Color.fromRGBO(46, 198, 255, 1), // rgb(46, 198, 255)
  Color.fromRGBO(123, 201, 82, 1), // rgb(123, 201, 82)
  Color.fromRGBO(255, 171, 67, 1), // rgb(255, 171, 67)
  Color.fromRGBO(252, 91, 57, 1), //  rgb(252, 91, 57)
  Color.fromRGBO(139, 135, 130, 1), //rgb(139, 135, 130)
];