import 'package:qr_code_demo/config/moneyformat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedFlipCounter extends StatelessWidget {
  final int value;
  final Duration duration;
  final double size;
  final Color color;

  const AnimatedFlipCounter({
    Key key,
    @required this.value,
    @required this.duration,
    this.size = 72,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> digitsString = [];

    String valueString = MoneyFormat.moneyFormat(value.toString());

    for (var i = 0; i < valueString.length; i++) {
      String singleString = valueString.toString().substring(
          valueString.toString().length - 1 - i,
          valueString.toString().length - i);
      digitsString.add(singleString);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(digitsString.length, (int i) {
        return _SingleDigitFlipCounter(
          key: ValueKey(digitsString.length - i),
          value: digitsString[digitsString.length - i - 1],
          duration: duration,
          height: size,
          width: size / 1.8,
          color: color,
        );
      }),
    );
  }
}

class _SingleDigitFlipCounter extends StatelessWidget {
  final String value;
  final Duration duration;
  final double height;
  final double width;
  final Color color;

  const _SingleDigitFlipCounter({
    Key key,
    @required this.value,
    @required this.duration,
    @required this.height,
    @required this.width,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value == ',') {
      return SizedBox(
        height: height + 3,
        width: width,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SizedBox(
              width: width,
              child: Opacity(
                opacity: 1,
                child: Text(
                  ',',
                  style: TextStyle(
                      fontSize: height,
                      color: color,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      );
    }
    return TweenAnimationBuilder(
      tween: Tween(begin: double.parse(value), end: double.parse(value)),
      duration: duration,
      builder: (context, value, child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        return SizedBox(
          height: height,
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildSingleDigit(
                digit: whole % 10,
                offset: height * decimal,
                opacity: 1 - decimal,
              ),
              _buildSingleDigit(
                digit: (whole + 1) % 10,
                offset: height * decimal - height,
                opacity: decimal,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSingleDigit({int digit, double offset, double opacity}) {
    return Positioned(
      child: SizedBox(
        width: width,
        child: Opacity(
          opacity: opacity,
          child: Text(
            MoneyFormat.moneyFormat(digit.toString()),
            style: TextStyle(
                fontSize: 16, color: color, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      bottom: offset,
    );
  }
}
