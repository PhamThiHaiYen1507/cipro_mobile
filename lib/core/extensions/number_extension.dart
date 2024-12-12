import 'package:flutter/material.dart';

extension NumberExtension on num {
  BorderRadius get radius => BorderRadius.all(Radius.circular(toDouble()));

  EdgeInsets get padding => EdgeInsets.all(toDouble());

  Duration get seconds => Duration(seconds: floor());

  Duration get milliseconds => Duration(milliseconds: floor());
}
