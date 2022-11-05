import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:simba_courier/core/extentions.dart';
import 'package:simba_courier/core/utils/pdf_model.dart';

class PdfReportApi {
  Future<File> generate(PdfModel pdfModel) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => [
        _buildHeader(pdfModel),
        SizedBox(
          height: 1.1 * PdfPageFormat.cm,
        ),
        _buildTable(pdfModel),
        _buildFooter(pdfModel)
      ],
    ));
    return PdfApi.saveDocumant(name: 'report.pdf', pdf: pdf);
  }

  Widget _buildFooter(pdfModel) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 1.1 * PdfPageFormat.cm,
        ),
        Divider(),
        Row(
          children: <Widget>[Spacer(), Text('Simba Courier')],
        ),
        Row(
          children: <Widget>[
            Spacer(),
            Text('Developed by\n Abdullah', style: const TextStyle(fontSize: 8))
          ],
        )
      ],
    );
  }

  _buildTable(PdfModel pdfModel) {
    final headers = [
      'Delivered By',
      'Waybill',
      'Quantity',
      'Weight',
      'Source',
      'Destination',
      'Status ID',
    ];
    final data = pdfModel.shipment.map((e) {
      return [
        e.deliveredBy?.trim() ?? 'Unknown',
        e.waybill!.trim(),
        e.quantity!.trim(),
        e.weight!.trim(),
        e.sourceRegion!.trim(),
        e.destinationRegion!.trim(),
        e.statusId!.trim()
      ];
    }).toList();
    return Table.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        cellStyle: const TextStyle(fontSize: 8),
        headerDecoration: const BoxDecoration(color: PdfColors.grey300));
  }

  _buildHeader(PdfModel pdfModel) => Column(
        children: <Widget>[
          Text('Report',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 0.8 * PdfPageFormat.cm,
          ),
          Row(
            children: <Widget>[
              Text('Name:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 0.5 * PdfPageFormat.cm,
              ),
              Text(pdfModel.customerName, style: const TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(
            height: 0.5 * PdfPageFormat.cm,
          ),
          Row(
            children: <Widget>[
              Text('Phone:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 0.5 * PdfPageFormat.cm,
              ),
              Text(pdfModel.phone, style: const TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(
            height: 0.5 * PdfPageFormat.cm,
          ),
          Row(
            children: <Widget>[
              Text('Date:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 0.5 * PdfPageFormat.cm,
              ),
              Text(pdfModel.date, style: const TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(
            height: 0.5 * PdfPageFormat.cm,
          ),
          Row(
            children: <Widget>[
              Text('Day:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 0.5 * PdfPageFormat.cm,
              ),
              Text(DateTime.now().weekday.daysOfTheWeek(),
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(
            height: PdfPageFormat.cm,
          ),
          Divider(),
        ],
      );
}

class PdfApi {
  static Future<File> saveDocumant(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
