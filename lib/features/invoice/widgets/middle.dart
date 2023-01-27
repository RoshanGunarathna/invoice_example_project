// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:invoice/models/ceiling_model.dart';

import '../../../colors.dart';

class Middle extends StatelessWidget {
  final List<CeilingModel> ceilingItemList;
  final TextStyle style;
  final TextStyle style2;
  final Color style3;
  const Middle({
    Key? key,
    required this.ceilingItemList,
    required this.style,
    required this.style2,
    required this.style3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: ceilingItemList.length,
          itemBuilder: (context, index) {
            var ceilingItem = ceilingItemList[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              color: whiteColor,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: style3,
                    width: 30,
                    child: Text(
                      index < 10 ? '0${index + 1}' : '${index + 1}',
                      style: style2,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ceilingItem.item,
                        style: style2,
                      ),
                    ),
                  ),
                  Container(
                    color: style3,
                    alignment: Alignment.center,
                    width: 63,
                    child: Text(
                      '${ceilingItem.size}"',
                      style: style2,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 63,
                    child: Text(
                      '${ceilingItem.price}',
                      style: style2,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: style3,
                    width: 63,
                    child: Text(
                      '${ceilingItem.quantity} PCS',
                      style: style2,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 63,
                    child: Text(
                      '${ceilingItem.price * ceilingItem.quantity}',
                      style: style2,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
