import 'package:core/utils/constants.dart';
import 'package:core/utils/string_utils.dart';
import 'package:core/widget/custom_divider.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:core/widget/item_with_value.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_data_response.dart';
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ItemWithValue(
                  "${reportDataList.title}",
                  "${reportDataList.totalTime} Hours",
                  textStyle: body1SemiBold.copyWith(fontSize: 18),
                  fontSize: 18,
                ),
              ),
            ),
            customHeight(),
            /*FittedBox(
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(primaryColor),
                  headingRowHeight: 32,
                  columns: const [
                    DataColumn(label: Text('Epic')),
                    DataColumn(label: Text('Intent')),
                    DataColumn(label: Text('Subtasks')),
                    DataColumn(label: Text('Complexity(1-5)')),
                    DataColumn(label: Text('Duration(Hours)'))
                  ],
                  rows: List<DataRow>.generate(
                    reportDataList.breakdownDataList!.length,
                    (index) => DataRow(
                      cells: [
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
                  ).toList()),
            ),*/

            Table(
              columnWidths: const {
                0: FractionColumnWidth(.2),
                1: FractionColumnWidth(.3),
                2: FractionColumnWidth(.2),
                3: FractionColumnWidth(.15),
                4: FractionColumnWidth(.15)
              },
              children: [
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
                  2: FractionColumnWidth(.23),
                  3: FractionColumnWidth(.17),
                  4: FractionColumnWidth(.15)
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
