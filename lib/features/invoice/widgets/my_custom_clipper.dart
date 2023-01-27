// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class MyCustomClipper extends CustomClipper<Path> {
  final double positon;
  MyCustomClipper({
    required this.positon,
  });
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(size.width * positon, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
