import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_code_demo/config/colors.dart';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
      angle: -pi / 1.7,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .9,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: ColorConstants.cepColorBackground,
          ),
        ),
      ),
    ));
  }
}
