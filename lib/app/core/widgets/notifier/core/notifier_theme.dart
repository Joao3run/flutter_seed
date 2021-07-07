import 'package:flutter/material.dart';
import './constants.dart';
import './notifier_position.dart';

class NotifierTheme extends InheritedWidget {
  final TextStyle textStyle;

  final Color backgroundColor;

  final double radius;

  final NotifierPosition position;

  final bool dismissOtherOnShow;

  final bool movingOnWindowChange;

  final TextDirection textDirection;

  final EdgeInsets? textPadding;

  final TextAlign? textAlign;

  final bool handleTouch;

  final NotifierAnimationBuilder animationBuilder;

  final Duration animationDuration;

  final Curve animationCurve;

  final Duration duration;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  const NotifierTheme({
    required this.textStyle,
    this.backgroundColor = Colors.blue,
    required this.radius,
    required this.position,
    this.dismissOtherOnShow = true,
    this.movingOnWindowChange = true,
    this.textPadding,
    this.textAlign,
    required this.textDirection,
    required this.handleTouch,
    required Widget child,
    this.animationBuilder = defaultBuildAnimation,
    this.animationDuration = defaultAnimDuration,
    this.animationCurve = Curves.easeIn,
    this.duration = defaultDuration,
  }) : super(child: child);

  static NotifierTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NotifierTheme>() ??
          defaultTheme;
}
