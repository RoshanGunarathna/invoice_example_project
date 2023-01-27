// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../colors.dart';
import 'my_custom_clipper.dart';

class Top extends StatelessWidget {
  final Size size;
  final TextStyle style;

  const Top({
    Key? key,
    required this.size,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.15,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: size.width * 0.423,
            padding: EdgeInsets.only(
              right: size.width * 0.05,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'INVOICE',
                  style: TextStyle(
                      fontSize: 47,
                      fontWeight: FontWeight.w400,
                      color: whiteColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Invoice#',
                      style: style.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '52148',
                      style: style.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: style.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '01 / 02 / 2020',
                      style: style.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          ),
          Stack(
            children: [
              ClipPath(
                clipper: MyCustomClipper(positon: 0.30),
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
                  clipper: MyCustomClipper(positon: 0.30),
                  child: Container(
                    padding:
                        const EdgeInsets.only(right: 27, top: 7, bottom: 7),
                    alignment: Alignment.centerRight,
                    width: size.width * 0.48,
                    decoration: const BoxDecoration(
                      color: liteGrayColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'assets/images/invoice_default_avatar.png',
                        fit: BoxFit.fitHeight,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
