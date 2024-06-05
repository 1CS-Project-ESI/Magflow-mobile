// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class CommandGraph extends StatelessWidget {
//   final List<int> commandCounts;

//   const CommandGraph({Key? key, required this.commandCounts}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Number of Commands per Month',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 16),
//           AspectRatio(
//             aspectRatio: 1.5,
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: (commandCounts.isNotEmpty
//                         ? commandCounts.reduce((a, b) => a > b ? a : b)
//                         : 0)
//                     .toDouble(),
//                 barTouchData: BarTouchData(enabled: false),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context) => const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     margin: 16,
//                     getTitles: (double value) {
//                       switch (value.toInt()) {
//                         case 0:
//                           return 'Jan';
//                         case 1:
//                           return 'Feb';
//                         case 2:
//                           return 'Mar';
//                         case 3:
//                           return 'Apr';
//                         case 4:
//                           return 'May';
//                         case 5:
//                           return 'Jun';
//                         case 6:
//                           return 'Jul';
//                         case 7:
//                           return 'Aug';
//                         case 8:
//                           return 'Sep';
//                         case 9:
//                           return 'Oct';
//                         case 10:
//                           return 'Nov';
//                         case 11:
//                           return 'Dec';
//                         default:
//                           return '';
//                       }
//                     },
//                   ),
//                   leftTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context) => const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     margin: 16,
//                     reservedSize: 28,
//                     interval: 1,
//                     getTitles: (value) {
//                       return value.toInt().toString();
//                     },
//                   ),
//                 ),
//                 borderData: FlBorderData(
//                   show: false,
//                 ),
//                 barGroups: List.generate(12, (i) {
//                   return BarChartGroupData(
//                     x: i,
//                     barRods: [
//                       BarChartRodData(
//                         y: i < commandCounts.length
//                             ? commandCounts[i].toDouble()
//                             : 0,
//                         colors: [Colors.blueAccent],
//                         width: 16,
//                       ),
//                     ],
//                     showingTooltipIndicators: [0],
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class CommandGraph extends StatelessWidget {
//   final List<int> commandCounts;

//   const CommandGraph({Key? key, required this.commandCounts}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Number of Commands per Month',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 16),
//           AspectRatio(
//             aspectRatio: 1.5,
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: (commandCounts.isNotEmpty
//                         ? commandCounts.reduce((a, b) => a > b ? a : b)
//                         : 0)
//                     .toDouble(),
//                 barTouchData: BarTouchData(enabled: false),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context) => const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     margin: 16,
//                     getTitles: (double value) {
//                       switch (value.toInt()) {
//                         case 0:
//                           return 'Jan';
//                         case 1:
//                           return 'Feb';
//                         case 2:
//                           return 'Mar';
//                         case 3:
//                           return 'Apr';
//                         case 4:
//                           return 'May';
//                         case 5:
//                           return 'Jun';
//                         case 6:
//                           return 'Jul';
//                         case 7:
//                           return 'Aug';
//                         case 8:
//                           return 'Sep';
//                         case 9:
//                           return 'Oct';
//                         case 10:
//                           return 'Nov';
//                         case 11:
//                           return 'Dec';
//                         default:
//                           return '';
//                       }
//                     },
//                   ),
//                   leftTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context) => const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     margin: 16,
//                     reservedSize: 28,
//                     interval: 1,
//                     getTitles: (value) {
//                       return value.toInt().toString();
//                     },
//                   ),
//                 ),
//                 borderData: FlBorderData(
//                   show: false,
//                 ),
//                 barGroups: List.generate(12, (i) {
//                   return BarChartGroupData(
//                     x: i,
//                     barRods: [
//                       BarChartRodData(
//                         y: i < commandCounts.length
//                             ? commandCounts[i].toDouble()
//                             : 0,
//                         colors: [Colors.blueAccent],
//                         width: 16,
//                       ),
//                     ],
//                     showingTooltipIndicators: [0],
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///////////////// trying
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class CommandGraph extends StatelessWidget {
//   final List<int> commandCounts;

//   const CommandGraph({Key? key, required this.commandCounts}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Determine the maximum value for the y-axis
//     final maxY = (commandCounts.isNotEmpty
//             ? commandCounts.reduce((a, b) => a > b ? a : b)
//             : 0)
//         .toDouble();

//     return Container(
//       margin: const EdgeInsets.only(top: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Number of Commands per Month',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 16),
//           AspectRatio(
//             aspectRatio: 1.5,
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: maxY > 0 ? maxY : 1,
//                 barTouchData: BarTouchData(enabled: false),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context) => const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     margin: 16,
//                     getTitles: (double value) {
//                       switch (value.toInt()) {
//                         case 0:
//                           return 'Jan';
//                         case 1:
//                           return 'Feb';
//                         case 2:
//                           return 'Mar';
//                         case 3:
//                           return 'Apr';
//                         case 4:
//                           return 'May';
//                         case 5:
//                           return 'Jun';
//                         case 6:
//                           return 'Jul';
//                         case 7:
//                           return 'Aug';
//                         case 8:
//                           return 'Sep';
//                         case 9:
//                           return 'Oct';
//                         case 10:
//                           return 'Nov';
//                         case 11:
//                           return 'Dec';
//                         default:
//                           return '';
//                       }
//                     },
//                   ),
//                   leftTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context) => const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     margin: 16,
//                     reservedSize: 28,
//                     interval: (maxY / 5)
//                         .ceilToDouble(), // Adjust interval for better display
//                     getTitles: (value) {
//                       return value.toInt().toString();
//                     },
//                   ),
//                 ),
//                 borderData: FlBorderData(
//                   show: false,
//                 ),
//                 barGroups: List.generate(12, (i) {
//                   return BarChartGroupData(
//                     x: i,
//                     barRods: [
//                       BarChartRodData(
//                         y: i < commandCounts.length
//                             ? commandCounts[i].toDouble()
//                             : 0,
//                         colors: [Colors.blueAccent],
//                         width: 16,
//                       ),
//                     ],
//                     showingTooltipIndicators: [0],
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class CommandGraph extends StatelessWidget {
//   final List<int> commandCounts;

//   const CommandGraph({Key? key, required this.commandCounts}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Determine the maximum value for the y-axis
//     final maxY = (commandCounts.isNotEmpty
//             ? commandCounts.reduce((a, b) => a > b ? a : b)
//             : 0)
//         .toDouble();

//     // Determine the interval for the y-axis titles
//     final interval = maxY > 0 ? (maxY / 5).ceilToDouble() : 1;

//     return Container(
//       margin: const EdgeInsets.only(top: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Number of Commands per Month',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 16),
//           AspectRatio(
//             aspectRatio: 1.5,
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: maxY > 0 ? maxY : 1,
//                 barTouchData: BarTouchData(enabled: false),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context) => const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     margin: 16,
//                     getTitles: (double value) {
//                       switch (value.toInt()) {
//                         case 0:
//                           return 'Jan';
//                         case 1:
//                           return 'Feb';
//                         case 2:
//                           return 'Mar';
//                         case 3:
//                           return 'Apr';
//                         case 4:
//                           return 'May';
//                         case 5:
//                           return 'Jun';
//                         case 6:
//                           return 'Jul';
//                         case 7:
//                           return 'Aug';
//                         case 8:
//                           return 'Sep';
//                         case 9:
//                           return 'Oct';
//                         case 10:
//                           return 'Nov';
//                         case 11:
//                           return 'Dec';
//                         default:
//                           return '';
//                       }
//                     },
//                   ),
//                   leftTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context) => const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     margin: 16,
//                     reservedSize: 28,
//                     // interval: interval, // Ensure interval is not zero
//                     getTitles: (value) {
//                       return value.toInt().toString();
//                     },
//                   ),
//                 ),
//                 borderData: FlBorderData(
//                   show: false,
//                 ),
//                 barGroups: List.generate(12, (i) {
//                   return BarChartGroupData(
//                     x: i,
//                     barRods: [
//                       BarChartRodData(
//                         y: i < commandCounts.length
//                             ? commandCounts[i].toDouble()
//                             : 0,
//                         colors: [Colors.blueAccent],
//                         width: 16,
//                       ),
//                     ],
//                     showingTooltipIndicators: [0],
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CommandGraph extends StatelessWidget {
  final List<int> commandCounts;

  const CommandGraph({Key? key, required this.commandCounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the maximum value for the y-axis
    final maxY = (commandCounts.isNotEmpty
            ? commandCounts.reduce((a, b) => a > b ? a : b)
            : 0)
        .toDouble();

    // Determine the interval for the y-axis titles
    final interval = maxY > 0 ? (maxY / 5).ceilToDouble() : 1;

    // List of month names
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Number of Commands per Month',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY > 0 ? maxY : 1,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context) => const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    margin: 16,
                    getTitles: (double value) {
                      return months[value.toInt()];
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context) => const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    margin: 16,
                    reservedSize: 28,
                    interval: interval.toDouble(), // Cast to double
                    getTitles: (value) {
                      return value.toInt().toString();
                    },
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: List.generate(12, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        y: i < commandCounts.length
                            ? commandCounts[i].toDouble()
                            : 0,
                        colors: [Colors.blueAccent],
                        width: 16,
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}