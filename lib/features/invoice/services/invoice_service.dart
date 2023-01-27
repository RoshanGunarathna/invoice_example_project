import 'dart:io';

import 'package:flutter/services.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/src/types/interface.dart';

class InvoiceServices {
  static Future<Uint8List> createInvoice(
      {required Uint8List screenShot}) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context pwContext) {
          return pw.Expanded(
            child: pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
          );
        },
      ),
    );

    var savedPdf = await pdf.save();

    return savedPdf;

    // print(savedPdf.runtimeType);

    // //save & open PDF
    // final output = await getTemporaryDirectory();
    // var filePath = "${output.path}/invoice.pdf";
    // final file = File(filePath);
    // await file.writeAsBytes(savedPdf);
    // print(filePath);
    // await OpenFile.open(filePath);
  }

  static Future<String?> downloadPdfFile({
    required Uint8List fileData,
    required String fileName,
  }) async {
    //storage permission check
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    //create ditectory
    var directory = await DownloadsPath.downloadsDirectory();

    if (directory != null) {
      //path set
      final filePath = "${directory.path}/$fileName.pdf";
      final file = File(filePath);

      //crate file
      var t = await file.writeAsBytes(fileData);
      print('**** ${t.runtimeType}');

      return filePath;
    }
    return null;
  }

  //share pdf
  static Future<void> sharePdfFile({
    required Uint8List fileData,
    required String fileName,
  }) async {
    //create ditectory
    final output = await getTemporaryDirectory();

    //set file path
    var filePath = "${output.path}/$fileName.pdf";

    final file = File(filePath);
    await file.writeAsBytes(fileData);
    print(file.path);

    Share.shareFiles([filePath]);
  }
}
