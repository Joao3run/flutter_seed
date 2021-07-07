import 'package:flutter/material.dart';

abstract class BaseAnimationBuilder {
  const BaseAnimationBuilder();

  Widget call(
      BuildContext context,
      Widget child,
      AnimationController controller,
      double percent,
      ) {
    return buildWidget(context, child, controller, percent);
  }

  Widget buildWidget(BuildContext context, Widget child,
      AnimationController controller, double percent);
}
