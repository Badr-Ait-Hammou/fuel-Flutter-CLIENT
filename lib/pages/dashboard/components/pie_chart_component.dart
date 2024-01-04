// import 'package:flutter/material.dart';
// import 'package:fuelflutter/model/chart.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class PieChartDash extends StatelessWidget {
//   final List<ChartDataModel> dataSource;
//
//   const PieChartDash({Key? key, required this.dataSource}) : super(key: key);
//
//   double calculateRequiredWidth(String headerText, String montantText) {
//     final textMaxWidth = headerText.length > montantText.length
//         ? headerText.length
//         : montantText.length;
//     return textMaxWidth * 10;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     final isPortrait = mediaQuery.orientation == Orientation.portrait;
//
//     return SizedBox(
//       width: isPortrait ? screenWidth * 0.9 : screenHeight * 0.5,
//       height: isPortrait ? screenWidth * 0.9 : screenHeight * 0.5,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 100,
//             child: ListView.builder(
//               itemCount: dataSource.length,
//               itemBuilder: (context, index) {
//                 final data = dataSource[index];
//
//                 return Padding(
//                   padding: EdgeInsets.symmetric(vertical: 2.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(40),
//                           color: data.couleur,
//                         ),
//                         height: 15,
//                         width: 15,
//                       ),
//                       SizedBox(width: 2),
//                       Text(
//                         "${data.label}:",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         "${data.montant} MAD",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 15.0),
//             child: LayoutBuilder(
//               builder: (BuildContext context, BoxConstraints constraints) {
//                 double aspectRatio = 1.0;
//                 if (MediaQuery.of(context).orientation ==
//                     Orientation.portrait) {
//                   aspectRatio = 1.2;
//                 } else {
//                   aspectRatio = 2.0;
//                 }
//                 return AspectRatio(
//                   aspectRatio: aspectRatio,
//                   child: SfCircularChart(
//                     series: <CircularSeries>[
//                       PieSeries<ChartDataModel, String>(
//                         dataSource: dataSource,
//                         xValueMapper: (ChartDataModel sales, _) => sales.label,
//                         yValueMapper: (ChartDataModel sales, _) =>
//                             double.parse(sales.pourcentage),
//                         pointColorMapper: (ChartDataModel sales, _) =>
//                             sales.couleur,
//                         dataLabelSettings: DataLabelSettings(isVisible: true),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
