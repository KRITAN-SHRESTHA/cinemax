import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NumX on num {
  SizedBox get horizontalBox => SizedBox(width: toDouble());

  SizedBox get verticalBox => SizedBox(height: toDouble());

  BorderRadiusGeometry get rounded => BorderRadius.circular(toDouble());

  EdgeInsets get all => EdgeInsets.all(toDouble());

  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());

  Duration get microseconds => Duration(microseconds: toInt());

  Duration get milliseconds => Duration(milliseconds: toInt());

  Duration get seconds => Duration(seconds: toInt());
}

extension WidgetX on Widget {
  // decorated circular
  BorderRadiusGeometry rounded(double radius) => BorderRadius.circular(radius);

  Padding px(double padding) => Padding(
    padding: EdgeInsets.symmetric(horizontal: padding),
    child: this,
  );

  Padding py(double padding) => Padding(
    padding: EdgeInsets.symmetric(vertical: padding),
    child: this,
  );

  Padding pOnly({
    double top = 0,
    double right = 0,
    double bottom = 0,
    double left = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
    ),
    child: this,
  );

  Padding pad(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Container mBottom(double value) => Container(
    margin: EdgeInsets.only(bottom: value),
    child: this,
  );
}
