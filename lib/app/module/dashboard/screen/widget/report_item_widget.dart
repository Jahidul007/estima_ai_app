import 'package:core/utils/constants.dart';
import 'package:core/utils/string_utils.dart';
import 'package:core/widget/custom_divider.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:core/widget/item_with_value.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_data_response.dart';
import 'package:flutter/material.dart';

class ReportItemWidget extends StatelessWidget {
  final ReportDataList reportDataList;

  const ReportItemWidget({Key? key, required this.reportDataList})
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
              "${reportDataList.totalTime} Hours",
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
              children:  [
                // first table row
                TableRow(
                  children: [
                    Container(
                        color: primaryColor,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Epic',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    Container(
                        color: primaryColor,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Intent',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    Container(
                        color: primaryColor,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Subtasks',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    Container(
                        color: primaryColor,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Complexity(1-5)',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    Container(
                        color: primaryColor,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Durations(Hours)',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
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
