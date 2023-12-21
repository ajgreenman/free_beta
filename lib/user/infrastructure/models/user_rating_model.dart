// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:free_beta/app/enums/enums.dart';

class UserRatingModel {
  UserRatingModel.withBoulder({
    required this.boulderRating,
    required this.unattempted,
    required this.inProgress,
    required this.completed,
  }) : yosemiteRating = null;

  UserRatingModel.withYosemite({
    required this.yosemiteRating,
    required this.unattempted,
    required this.inProgress,
    required this.completed,
  }) : boulderRating = null;

  final BoulderRating? boulderRating;
  final CondensedYosemiteRating? yosemiteRating;
  final double unattempted;
  final double inProgress;
  final double completed;

  double get totalCount => unattempted + inProgress + completed;
  String get unattemptedCount => '${unattempted.toInt()}/${totalCount.toInt()}';
  String get inProgressCount => '${inProgress.toInt()}/${totalCount.toInt()}';
  String get completedCount => '${completed.toInt()}/${totalCount.toInt()}';

  @override
  String toString() {
    return 'UserRatingModel(boulderRating: $boulderRating, yosemiteRating: $yosemiteRating, unattempted: $unattempted, inProgress: $inProgress, completed: $completed)';
  }
}


// BarChartData(
//           barGroups: [
//             BarChartGroupData(
//               x: 0,
//               barRods: [
//                 BarChartRodData(
//                   toY: 3,
//                   color: FreeBetaColors.blue,
//                 ),
//                 BarChartRodData(
//                   toY: 9,
//                   color: FreeBetaColors.blueLight,
//                 ),
//                 BarChartRodData(
//                   toY: 6,
//                   color: FreeBetaColors.blueDark,
//                 ),
//               ],
//             ),
//             BarChartGroupData(
//               x: 1,
//               barRods: [
//                 BarChartRodData(
//                   toY: 9,
//                   borderRadius: BorderRadius.zero,
//                   rodStackItems: [
//                     BarChartRodStackItem(6, 9, FreeBetaColors.red),
//                     BarChartRodStackItem(3, 6, FreeBetaColors.yellowBrand),
//                     BarChartRodStackItem(0, 3, FreeBetaColors.green),
//                   ],
//                 ),
//               ],
//             ),
//             BarChartGroupData(
//               x: 2,
//             ),
//           ],
//           barTouchData: BarTouchData(enabled: false),
//           gridData: const FlGridData(
//             drawVerticalLine: false,
//             horizontalInterval: 3,
//           ),
//           titlesData: FlTitlesData(
//             topTitles: AxisTitles(),
//             rightTitles: AxisTitles(),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 interval: 3,
//                 showTitles: true,
//               ),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (i, _) => Text(
//                   BoulderRating.values[i.toInt()].displayName,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );