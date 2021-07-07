import 'package:flutter/material.dart';
import './notifier_theme.dart';
import './notifier_position.dart';

const NotifierTheme defaultTheme = const NotifierTheme(
  radius: 10,
  textStyle: defaultTextStyle,
  position: NotifierPosition.center,
  textDirection: TextDirection.ltr,
  handleTouch: false,
  child: const SizedBox(),
  animationBuilder: defaultBuildAnimation,
);

const TextStyle defaultTextStyle = const TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);

const defaultAnimDuration = const Duration(seconds: 6);

const defaultDuration = Duration(
  milliseconds: 2300,
);

const defaultBackgroundColor = const Color(0xEEEEEEEE);

Widget defaultBuildAnimation(BuildContext context, Widget child,
    AnimationController controller, double percent) {
  return Opacity(
    opacity: percent,
    child: child,
  );
}


typedef Widget NotifierAnimationBuilder(
    BuildContext context,
    Widget child,
    AnimationController controller,
    double percent,
    );
