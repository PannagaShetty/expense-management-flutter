import 'package:flutter/material.dart';

extension UiSpacingInt on int {
  get verticalSpace => SizedBox(
        height: toDouble(),
      );

  get horizontalSpace => SizedBox(
        width: toDouble(),
      );
}
