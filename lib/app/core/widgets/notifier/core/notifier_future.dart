import 'dart:async';

import 'package:flutter/material.dart';
import './notifier_manager.dart';
import './notifier_container.dart';

class NotifierFuture {
  final OverlayEntry _entry;
  final VoidCallback? _onDismiss;
  bool _isShow = true;
  late Timer timer;
  final GlobalKey<NotifierContainerState> _containerKey;
  final Duration animationDuration;

  NotifierFuture(
      this._entry,
      this._onDismiss,
      this._containerKey,
      this.animationDuration,
      );

  void dismiss({bool showAnim = false}) {
    if (!_isShow) {
      return;
    }
    _isShow = false;
    _onDismiss?.call();
    NotifierManager().removeFuture(this);

    if (showAnim) {
      _containerKey.currentState?.showDismissAnim();
      Future.delayed(animationDuration, () {
        _entry.remove();
      });
    } else {
      _entry.remove();
    }

    timer.cancel();
  }
}
