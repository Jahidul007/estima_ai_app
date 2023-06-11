import 'package:core/repository/base_repository.dart';
import 'package:core/utils/string_utils.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_profile_history_response.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:core/utils/extension/string_extension.dart';
import 'save_file_mobile.dart'
    if (dart.library.html) 'save_file_web.dart';

class PDFDownloadGenerator extends BaseRepository {
  final ReportHistories reportHistories;

  PDFDownloadGenerator(this.reportHistories);

  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle

    //Generate PDF grid.
    PdfGrid grid = getGrid(reportHistories);

    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    drawFooter(page, pageSize);
    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    await saveAndLaunchFile(bytes, '${reportHistories.title}.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(49, 119, 115)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 60));
    //Draw string
    page.graphics.drawString(
        'Paglaa AI Inc.', PdfStandardFont(PdfFontFamily.helvetica, 24),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 60),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 60),
        brush: PdfSolidBrush(PdfColor(49, 119, 115)));

    page.graphics.drawString('${reportHistories.jsonData?.totalTime}',
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Total Estimated Time\n(Hours)', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));


    final String invoiceNumber =
        '\tEstimation Number: ${reportHistories.id}\tDate: '
        '${reportHistories.generationTime!.getFormattedDateFromFormattedString(
      currentFormat: "yyyy-mm-ddTHH:mm:ssZ",
      desiredFormat: "dd-MMM-yyyy hh:mm a",
    )}';
    final Size contentSize = contentFont.measureString(invoiceNumber);

    return PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page, bounds: Rect.fromLTWH(0, 80, contentSize.width + 30, 0))!;
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom+10, 0, 0))!;

    //Draw grand total.
    page.graphics.drawString(
        'Total Time: ${reportHistories.jsonData?.totalTime}',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds!.left,
            result.bounds.bottom + 10,
            quantityCellBounds!.width,
            quantityCellBounds!.height));
  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    const String footerContent =
        // ignore: leading_newlines_in_multiline_strings
        '''* This report is provided by EstimaAI.
    \r\n\rAny Questions? support@estima-ai.com''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid getGrid(ReportHistories reportHistories) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Specify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.

    reportHistories.jsonData!.reportDataList?.forEach(
      (element1) {
        addTitleTotalTime(defaultIfNull(element1.title),
            defaultIfNull("${element1.totalTime}"), grid);
        addHeader(grid);
        for (var element in element1.breakdownDataList!) {
          addProducts(
            defaultIfNull(element.featureTitle),
            defaultIfNull(element.featureIntent),
            defaultIfNull(element.subtasksOfFeatures),
            defaultIfNull(element.complexity),
            defaultIfNull(element.implementationTime),
            grid,
          );
        }
        addEmptyCells(grid);
        addEmptyCells(grid);
      },
    );

    grid.allowRowBreakingAcrossPages = true;
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        cell.stringFormat.alignment = PdfTextAlignment.center;
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(String productId, String productName, String price,
      String quantity, String total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = productId;
    row.cells[1].value = productName;
    row.cells[2].value = price.toString();
    row.cells[3].value = quantity.toString();
    row.cells[4].value = total.toString();
  }

  void addTitleTotalTime(String title, String total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[2].value = '$title (${total}hours)';
    row.cells[2].style = PdfGridCellStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 9,
            style: PdfFontStyle.bold,));
    addRowDesignForTitle(row);
  }

  void addHeader(PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.style.backgroundBrush = PdfSolidBrush(PdfColor(49, 119, 115));
    row.cells[0].value = 'Feature Title';
    row.cells[0].style = PdfGridCellStyle(
        textBrush:  PdfBrushes.white,
        font: PdfStandardFont(PdfFontFamily.helvetica, 9,
            style: PdfFontStyle.bold, ));
    row.cells[1].value = 'Feature Intent';
    row.cells[1].style = PdfGridCellStyle(
        textBrush:  PdfBrushes.white,
        font: PdfStandardFont(PdfFontFamily.helvetica, 9,
          style: PdfFontStyle.bold, ));
    row.cells[2].value = 'Subtasks of Features';
    row.cells[2].style = PdfGridCellStyle(
        textBrush:  PdfBrushes.white,
        font: PdfStandardFont(PdfFontFamily.helvetica, 9,
          style: PdfFontStyle.bold, ));
    row.cells[3].value = 'Complexity(1-5)';
    row.cells[3].style = PdfGridCellStyle(
        textBrush:  PdfBrushes.white,
        font: PdfStandardFont(PdfFontFamily.helvetica, 9,
          style: PdfFontStyle.bold, ));
    row.cells[4].value = 'Duration(hours)';
    row.cells[4].style = PdfGridCellStyle(
        textBrush:  PdfBrushes.white,
        font: PdfStandardFont(PdfFontFamily.helvetica, 9,
          style: PdfFontStyle.bold, ));
  }

  addEmptyCells(PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    addRowDesign(row);
  }

  addRowDesign(PdfGridRow row) {
    row.cells[0].style.borders = PdfBorders(
      left: PdfPens.transparent,
      right: PdfPens.transparent,
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
    );
    row.cells[1].style.borders = PdfBorders(
      right: PdfPens.transparent,
      left: PdfPens.transparent,
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
    );
    row.cells[2].style.borders = PdfBorders(
      right: PdfPens.transparent,
      left: PdfPens.transparent,
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
    );
    row.cells[3].style.borders = PdfBorders(
      right: PdfPens.transparent,
      left: PdfPens.transparent,
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
    );
    row.cells[4].style.borders = PdfBorders(
      right: PdfPens.transparent,
      left: PdfPens.transparent,
      bottom: PdfPens.transparent,
      top: PdfPens.transparent,
    );
  }

  addRowDesignForTitle(PdfGridRow row) {
    row.cells[0].style.borders = PdfBorders(
      right: PdfPens.transparent,
      bottom: PdfPens.transparent,
    );
    row.cells[1].style.borders = PdfBorders(
      right: PdfPens.transparent,
      left: PdfPens.transparent,
      bottom: PdfPens.transparent,
    );
    row.cells[2].style.borders = PdfBorders(
      right: PdfPens.transparent,
      left: PdfPens.transparent,
      bottom: PdfPens.transparent,
    );
    row.cells[3].style.borders = PdfBorders(
      right: PdfPens.transparent,
      left: PdfPens.transparent,
      bottom: PdfPens.transparent,
    );
    row.cells[4].style.borders = PdfBorders(
      left: PdfPens.transparent,
      bottom: PdfPens.transparent,
    );
  }
}
