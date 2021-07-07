import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import './notifier_theme.dart';
import './constants.dart';
import './notifier_position.dart';
import './notifier_future.dart';
import './notifier_container.dart';
import './notifier_manager.dart';


class Notifier extends StatefulWidget {
  final Widget child;

  final TextStyle? textStyle;

  final Color backgroundColor;

  final double radius;

  final NotifierPosition position;

  final TextDirection textDirection;

  final bool dismissOtherOnShow;

  final bool movingOnWindowChange;

  final EdgeInsets? textPadding;

  final TextAlign? textAlign;

  final bool handleTouch;

  final Duration? duration;

  final NotifierAnimationBuilder? animationBuilder;

  final Duration animationDuration;

  final Curve? animationCurve;

  const Notifier({
    Key? key,
    required this.child,
    this.textStyle,
    this.radius = 10.0,
    this.position = NotifierPosition.center,
    this.textDirection = TextDirection.ltr,
    this.dismissOtherOnShow = false,
    this.movingOnWindowChange = true,
    Color? backgroundColor,
    this.textPadding,
    this.textAlign,
    this.handleTouch = false,
    this.animationBuilder,
    this.animationDuration = defaultAnimDuration,
    this.animationCurve,
    this.duration,
  })  : this.backgroundColor = backgroundColor ?? defaultBackgroundColor,
        super(key: key);

  @override
  _NotifierState createState() => _NotifierState();
}

class _NotifierState extends State<Notifier> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    contextMap.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var overlay = Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (ctx) {
            contextMap[this] = ctx;
            return widget.child;
          },
        ),
      ],
    );

    TextDirection direction = widget.textDirection;

    Widget w = Directionality(
      child: overlay,
      textDirection: direction,
    );

    var typography = Typography.material2018(platform: TargetPlatform.android);
    final TextTheme defaultTextTheme = typography.white;

    TextStyle textStyle = widget.textStyle ??
        defaultTextTheme.bodyText2?.copyWith(
          fontSize: 15.0,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ) ??
        defaultTextStyle;

    TextAlign textAlign = widget.textAlign ?? TextAlign.center;
    EdgeInsets textPadding = widget.textPadding ??
        const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        );

    final NotifierAnimationBuilder animationBuilder =
        widget.animationBuilder ?? defaultBuildAnimation;

    return NotifierTheme(
      child: w,
      backgroundColor: widget.backgroundColor,
      radius: widget.radius,
      textStyle: textStyle,
      position: widget.position,
      dismissOtherOnShow: widget.dismissOtherOnShow,
      movingOnWindowChange: widget.movingOnWindowChange,
      textDirection: direction,
      textAlign: textAlign,
      textPadding: textPadding,
      handleTouch: widget.handleTouch,
      animationBuilder: animationBuilder,
      animationDuration: widget.animationDuration,
      animationCurve: widget.animationCurve ?? Curves.easeIn,
      duration: widget.duration ?? defaultDuration,
    );
  }
}

LinkedHashMap<_NotifierState, BuildContext> contextMap = LinkedHashMap();

NotifierFuture showNotifier(
    String msg, {
      BuildContext? context,
      Duration? duration,
      NotifierPosition? position,
      TextStyle? textStyle,
      EdgeInsetsGeometry? textPadding,
      Color? backgroundColor,
      double? radius,
      VoidCallback? onDismiss,
      TextDirection? textDirection,
      bool? dismissOtherNotifier,
      TextAlign? textAlign,
      NotifierAnimationBuilder? animationBuilder,
      Duration? animationDuration,
      Curve? animationCurve,
      Icon? icon,
    }) {
  context ??= contextMap.values.first;

  final theme = NotifierTheme.of(context);
  textStyle ??= theme.textStyle;
  textAlign ??= theme.textAlign;
  textPadding ??= theme.textPadding;
  position ??= theme.position;
  backgroundColor ??= theme.backgroundColor;
  radius ??= theme.radius;
  textDirection ??= theme.textDirection;

  Widget widget = Container(
    // margin: const EdgeInsets.all(50.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
    ),
    padding: textPadding,
    child: ClipRect(
      child: Row(
        children: [
          Text(
            msg,
            style: textStyle,
            textAlign: textAlign,
          ),
          icon!,
        ],
      ),
    ),
  );

  return showNotifierWidget(
    widget,
    animationBuilder: animationBuilder,
    animationDuration: animationDuration,
    context: context,
    duration: duration,
    onDismiss: onDismiss,
    position: position,
    dismissOtherNotifier: dismissOtherNotifier,
    textDirection: textDirection,
    animationCurve: animationCurve,
  );
}

NotifierFuture showNotifierWidget(
    Widget widget, {
      BuildContext? context,
      Duration? duration,
      NotifierPosition? position,
      VoidCallback? onDismiss,
      bool? dismissOtherNotifier,
      TextDirection? textDirection,
      bool? handleTouch,
      NotifierAnimationBuilder? animationBuilder,
      Duration? animationDuration,
      Curve? animationCurve,
    }) {
  context ??= contextMap.values.first;
  OverlayEntry entry;
  NotifierFuture future;
  final theme = NotifierTheme.of(context);

  position ??= theme.position;
  handleTouch ??= theme.handleTouch;
  animationBuilder ??= theme.animationBuilder;
  animationDuration ??= theme.animationDuration;
  animationCurve ??= theme.animationCurve;
  duration ??= theme.duration;

  final movingOnWindowChange = theme.movingOnWindowChange;

  final direction = textDirection ?? theme.textDirection;

  GlobalKey<NotifierContainerState> key = GlobalKey();

  widget = Align(
    child: widget,
    alignment: position.align,
  );

  entry = OverlayEntry(builder: (ctx) {
    return IgnorePointer(
      ignoring: !handleTouch!,
      child: Directionality(
        textDirection: direction,
        child: NotifierContainer(
          duration: duration!,
          position: position!,
          movingOnWindowChange: movingOnWindowChange,
          key: key,
          child: widget,
          animationBuilder: animationBuilder!,
          animationDuration: animationDuration!,
          animationCurve: animationCurve!,
        ),
      ),
    );
  });

  dismissOtherNotifier ??= theme.dismissOtherOnShow;

  if (dismissOtherNotifier == true) {
    NotifierManager().dismissAll();
  }

  future = NotifierFuture(entry, onDismiss, key, animationDuration);

  future.timer = Timer(duration, () {
    future.dismiss();
  });

  Overlay.of(context)?.insert(entry);
  NotifierManager().addFuture(future);

  return future;
}

void dismissAllNotifier({bool showAnim = false}) {
  NotifierManager().dismissAll(showAnim: showAnim);
}
