// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../colors.dart';
import 'my_custom_clipper.dart';

class Bottom extends StatelessWidget {
  final TextStyle style;
  final TextStyle style2;
  final Color style3;
  final Size size;
  final double subTotal;
  final double totalPrice;
  final int tax;
  final double discount;
  const Bottom({
    Key? key,
    required this.style,
    required this.style2,
    required this.style3,
    required this.size,
    required this.subTotal,
    required this.totalPrice,
    required this.tax,
    required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thank you for your business',
                style: style.copyWith(fontSize: 10),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                'Payment info',
                style: TextStyle(color: secondaryColor, fontSize: 11),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Account #',
                          style: style.copyWith(fontSize: 9),
                        ),
                        Text(
                          '1234 5678 9012',
                          style: style.copyWith(fontSize: 9),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'A/C Name',
                          style: style.copyWith(fontSize: 9),
                        ),
                        Text(
                          'Lerem Ipsum',
                          style: style.copyWith(fontSize: 9),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bank Details',
                          style: style.copyWith(fontSize: 9),
                        ),
                        Text(
                          'Add your bank details',
                          style: style.copyWith(fontSize: 7),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Text(
                'Terms & Conditions',
                style: TextStyle(color: secondaryColor, fontSize: 11),
              ),
              const SizedBox(height: 5),
              Text(
                'Write your terms & conditions',
                style: style.copyWith(fontSize: 9),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("SUB TOTAL:  "),
                      SizedBox(
                        height: 10,
                      ),
                      Text("TAX:  "),
                      SizedBox(
                        height: 10,
                      ),
                      Text("DISCOUNT:  "),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(subTotal.toString()),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('$tax%'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(discount.toString()),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: 250,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: MyCustomClipper(positon: 0.15),
                    child: Container(
                      width: size.width * 0.48,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27),
                    child: ClipPath(
                      clipper: MyCustomClipper(positon: 0.15),
                      child: Container(
                        padding:
                            const EdgeInsets.only(right: 27, top: 7, bottom: 7),
                        alignment: Alignment.center,
                        width: size.width * 0.48,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                        ),
                        child: Text(
                          "TOTAL:   $totalPrice",
                          style: const TextStyle(
                              color: whiteColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
