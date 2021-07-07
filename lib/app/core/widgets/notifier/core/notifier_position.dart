import 'package:flutter/material.dart';

class NotifierPosition {
  final AlignmentGeometry align;
  final double offset;

  const NotifierPosition({this.align = Alignment.center, this.offset = 0.0});

  static const center =
  const NotifierPosition(align: Alignment.center, offset: 0.0);

  static const bottom =
  const NotifierPosition(align: Alignment.bottomCenter, offset: -30.0);

  static const top =
  const NotifierPosition(align: Alignment.topCenter, offset: 75.0);

  @override
  String toString() {
    return "NotifierPosition [ align = $align, offset = $offset ] ";
  }
}

