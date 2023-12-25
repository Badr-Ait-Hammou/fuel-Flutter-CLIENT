import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fuelflutter/model/fuel.dart';

class PieChart extends StatelessWidget {
  const PieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraint) => Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(193, 214, 233, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(-5, -5),
                color: Colors.white,
              ),
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(7, 7),
                color: Color.fromRGBO(146, 182, 216, 1),
              )
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: constraint.maxWidth * 0.6,
                  child: CustomPaint(
                    child: Center(),
                    foregroundPainter: PieChartComponent(
                      width: constraint.maxWidth * 0.5,
                      categories: kCategories,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: constraint.maxWidth * 0.4,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(193, 214, 233, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: Offset(-1, -1),
                        color: Colors.white,
                      ),
                      BoxShadow(
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: Offset(5, 5),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text('\$1280.20'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PieChartComponent extends CustomPainter {
  PieChartComponent({required this.categories, required this.width});

  final List<Category> categories;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;

    categories.forEach((expense) => total += expense.amount);

    double startRadian = -pi / 2;

    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);

      final sweepRadian = currentCategory.amount / total * 2 * pi;

      paint.color = kNeumorphicColors.elementAt(index % categories.length);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );

      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var category in kCategories)
            ExpenseCategory(
                text: category.name, index: kCategories.indexOf(category))
        ],
      ),
    );
  }
}

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({
    Key? key,
    required this.index,
    required this.text,
  }) : super(key: key);

  final int index;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  kNeumorphicColors.elementAt(index % kNeumorphicColors.length),
            ),
          ),
          SizedBox(width: 20),
          Text(text.capitalize()),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
