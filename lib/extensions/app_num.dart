import 'package:flutter/material.dart';

extension AppNum on num {
  Widget get verticalSpace => SizedBox(height: toDouble());

  Widget get horizontalSpace => SizedBox(width: toDouble());

  Widget get progressIndicator => SizedBox(
      height: toDouble(),
      width: toDouble(),
      child: CircularProgressIndicator());
}
