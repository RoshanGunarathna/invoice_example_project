// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:invoice/colors.dart';
import 'package:invoice/features/invoice/services/invoice_service.dart';
import 'package:invoice/features/invoice/widgets/bottom.dart';
import 'package:invoice/features/invoice/widgets/middle.dart';

import 'package:invoice/models/ceiling_model.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../../common/utils/show_snackbar.dart';
import '../widgets/top.dart';

//temporary
import 'dart:math';

class InvoiceScreen extends StatefulWidget {
  static const routeName = '/invoice';
  final List<CeilingModel> ceilingItemList;
  const InvoiceScreen({
    Key? key,
    required this.ceilingItemList,
  }) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late double subTotal;
  int tax = 15;
  double discount = 1200;
  late double totalPrice;

  //controllers
  final _screenshotController = ScreenshotController();

  void calculation() {
    //find sub total
    double total = widget.ceilingItemList
        .map((e) {
          return e.price * e.quantity;
        })
        .toList()
        .sum;

    subTotal = total;

    //find total
    totalPrice = total - (tax / 100) * total + discount;
  }

//create pdf and save in "Download folder"
  void downloadPdf() async {
    Uint8List? screenshot = await _screenshotController.capture();

    if (screenshot != null) {
      //create pdf
      Uint8List data =
          await InvoiceServices.createInvoice(screenShot: screenshot);
      //random name for file
      final random = Random();
      int randomNumber = random.nextInt(100);

      //save in external storage
      final savedFilePath = await InvoiceServices.downloadPdfFile(
        fileData: data,
        fileName: '$randomNumber',
      );

      if (savedFilePath != null) {
        print('successfull');
        print(savedFilePath);
        showSnackBar(
            context: context,
            text: 'successfully saved to internal storage "Download" folder');
      }
    }
  }

//create pdf and share
  void sharePdf() async {
    Uint8List? screenshot = await _screenshotController.capture();

    if (screenshot != null) {
      //create pdf
      Uint8List data =
          await InvoiceServices.createInvoice(screenShot: screenshot);
      //random name for file
      final random = Random();
      int randomNumber = random.nextInt(100);

      //share pdf
      InvoiceServices.sharePdfFile(
        fileData: data,
        fileName: randomNumber.toString(),
      );
    }
  }

  //storage permission check
  void storagePermissionCheck() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    calculation();
    storagePermissionCheck();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = const TextStyle().copyWith(color: whiteColor);
    final style2 = const TextStyle().copyWith(color: primaryColor);
    var style3 = liteGrayColor;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[600]),
                onPressed: () {
                  downloadPdf();
                },
                child: const Text('Download PDF'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[600]),
                onPressed: () {
                  sharePdf();
                },
                child: const Text('Share PDF'),
              ),
            ),
          ],
        ),
        body: Screenshot(
          controller: _screenshotController,
          child: Stack(
            children: [
              Container(
                color: liteGrayColor,
                width: size.width * 0.4,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                color: leftSideBackgroundColor,
                width: size.width * 0.36,
              ),
              Column(
                children: [
                  Top(size: size, style: style),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    color: secondaryColor,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 30,
                          child: Text(
                            'NO',
                            style: style,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'ITEM',
                              style: style,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 63,
                          child: Text(
                            'SIZE',
                            style: style,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 63,
                          child: Text(
                            'PRICE',
                            style: style,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 63,
                          child: Text(
                            'QTY.',
                            style: style,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 63,
                          child: Text(
                            'TOTAL',
                            style: style,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  Middle(
                    ceilingItemList: widget.ceilingItemList,
                    style2: style2,
                    style3: style3,
                    style: style,
                  ),
                  Bottom(
                      style: style,
                      style2: style2,
                      style3: style3,
                      size: size,
                      subTotal: subTotal,
                      totalPrice: totalPrice,
                      tax: tax,
                      discount: discount),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
