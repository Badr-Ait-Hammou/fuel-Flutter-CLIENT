import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../components/appColors.dart';
import '../../../components/indicator.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: AppColors.contentColorBlue,
                text: 'First',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorYellow,
                text: 'Second',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorPurple,
                text: 'Third',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorGreen,
                text: 'Fourth',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorYellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorPurple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.contentColorGreen,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}





// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../components/app_colors.dart';
// import '../../../components/indicator.dart';
//
// class PieChartSample2 extends StatefulWidget {
//   const PieChartSample2({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }
//
// class PieChart2State extends State<PieChartSample2> {
//   int touchedIndex = -1;
//   List<PieChartSectionData> chartSections = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse('http://localhost:8090/api/fuel/user/1'));
//     print(response);
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//
//       setState(() {
//         chartSections = showingSections(data);
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child: Row(
//         children: <Widget>[
//           const SizedBox(
//             height: 18,
//           ),
//           Expanded(
//             child: AspectRatio(
//               aspectRatio: 1,
//               child: PieChart(
//                 PieChartData(
//                   pieTouchData: PieTouchData(
//                     touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                       SchedulerBinding.instance!.addPostFrameCallback((_) {
//                         setState(() {
//                           if (!event.isInterestedForInteractions ||
//                               pieTouchResponse == null ||
//                               pieTouchResponse.touchedSection == null) {
//                             touchedIndex = -1;
//                             return;
//                           }
//                           touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
//                         });
//                       });
//                     },
//                   ),
//                   borderData: FlBorderData(
//                     show: false,
//                   ),
//                   sectionsSpace: 0,
//                   centerSpaceRadius: 40,
//                   sections: chartSections,
//                 ),
//               ),
//             ),
//           ),
//           const Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Indicator(
//                 color: AppColors.contentColorBlue,
//                 text: 'Type 1',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Indicator(
//                 color: AppColors.contentColorYellow,
//                 text: 'Type 2',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Indicator(
//                 color: AppColors.contentColorPurple,
//                 text: 'Type 3',
//                 isSquare: true,
//               ),
//               // Add more indicators as needed based on your API response
//               SizedBox(
//                 height: 18,
//               ),
//             ],
//           ),
//           const SizedBox(
//             width: 28,
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<PieChartSectionData> showingSections(List<dynamic> data) {
//     return List.generate(data.length, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       final section = data[i];
//
//       // Extracting data from the inner arrays
//       final sectionTitle = section[0] as String;
//       final sectionLitres = section[1] as double;
//       final sectionTotal = section[2] as double;
//
//       return PieChartSectionData(
//         color: getRandomColor(),
//         value: sectionLitres,
//         title: '${sectionTitle}\n${sectionLitres.toStringAsFixed(2)}%',
//         radius: radius,
//         titleStyle: TextStyle(
//           fontSize: fontSize,
//           fontWeight: FontWeight.bold,
//           color: AppColors.mainTextColor1,
//           shadows: [Shadow(color: Colors.black, blurRadius: 2)],
//         ),
//       );
//     });
//   }
//
//   Color getRandomColor() {
//     return Colors.primaries[Random().nextInt(Colors.primaries.length)];
//   }
// }
