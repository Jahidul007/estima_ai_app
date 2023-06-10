import 'package:core/utils/constants.dart';
import 'package:core/utils/string_utils.dart';
import 'package:core/widget/custom_divider.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:core/widget/item_with_value.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_profile_history_response.dart';
import 'package:flutter/material.dart';

class FeatureBreakDownWidget extends StatelessWidget {
  final ReportDataList reportDataList;

  const FeatureBreakDownWidget({Key? key, required this.reportDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ItemWithValue(
              "${reportDataList.title}",
              "${reportDataList.totalTime}",
              textStyle: body1SemiBold.copyWith(fontSize: 18),
            ),
            customHeight(),
            Table(
              columnWidths: const {
                0: FractionColumnWidth(.2),
                1: FractionColumnWidth(.3),
                2: FractionColumnWidth(.2),
                3: FractionColumnWidth(.15),
                4: FractionColumnWidth(.2)
              },
              children: const [
                // first table row
                TableRow(
                  children: [
                    Text('Feature Title'),
                    Text('Feature Intent'),
                    Text('Subtasks of Features'),
                    Text('Complexity'),
                    Text('Durations'),
                  ],
                ),
              ],
            ),
            customDividerGrey(),
            Table(
                columnWidths: const {
                  0: FractionColumnWidth(.2),
                  1: FractionColumnWidth(.3),
                  2: FractionColumnWidth(.2),
                  3: FractionColumnWidth(.15),
                  4: FractionColumnWidth(.2)
                },
                children: List<TableRow>.generate(
                  reportDataList.breakdownDataList!.length,
                  (index) => TableRow(
                    children: [
                      getCellData(
                          '${reportDataList.breakdownDataList![index].featureTitle}'),
                      getCellData(
                          '${reportDataList.breakdownDataList![index].featureIntent}'),
                      getCellData(
                          '${reportDataList.breakdownDataList![index].subtasksOfFeatures}'),
                      getCellData(
                          '${reportDataList.breakdownDataList![index].complexity}'),
                      getCellData(
                          '${reportDataList.breakdownDataList![index].implementationTime}'),
                    ],
                  ),
                ).toList())
          ],
        ),
      ),
    );
  }

  getCellData(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(defaultIfNull(title)),
        customDividerGrey(),
      ],
    );
  }
}
