import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_seed/app/core/core.dart';

import '../loading.dart';

List<GlobalKey<_LoadingProviderState>> _keys = [];

class LoadingProvider extends StatefulWidget {
  final Widget child;

  final LoadingThemeData themeData = LoadingThemeData();

  final GlobalKey<_LoadingProviderState> key;

  final LoadingWidgetBuilder loadingWidgetBuilder;

  LoadingProvider({
    required this.child,
    this.loadingWidgetBuilder = LoadingWidget.buildDefaultLoadingWidget,
    Key? key,
  })  : key = createKey(),
        super(key: key);

  @override
  _LoadingProviderState createState() => _LoadingProviderState();

  static GlobalKey<_LoadingProviderState> createKey() {
    return GlobalKey();
  }
}

class _LoadingProviderState extends State<LoadingProvider> {
  GlobalKey<OverlayState> overlayKey = GlobalKey();

  GlobalKey<LoadingWidgetState> loadingKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _keys.add(widget.key);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Overlay(
        key: overlayKey,
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext context) {
              return widget.child;
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _keys.remove(widget.key);
    super.dispose();
  }

  LoadingDismissFuture showLoading({
    bool? tapDismiss,
  }) {
    tapDismiss ??= false;
    _realDismissDialog();
    LoadingThemeData themeData = widget.themeData;
    LoadingTheme w = LoadingTheme(
      data: themeData.copyWith(
        tapDismiss: tapDismiss,
      ),
      child: LoadingWidget(
        key: loadingKey,
        loadingWidgetBuilder: widget.loadingWidgetBuilder,
      ),
    );
    OverlayEntry entry = OverlayEntry(builder: (BuildContext context) {
      return w;
    });

    overlayKey.currentState?.insert(entry);

    LoadingDismissFuture future =
        LoadingDismissFuture(entry, loadingKey, themeData.animDuration);
    return future;
  }

  LoadingDismissFuture showLoadingWidget(
    Widget loadingWidget, {
    bool? tapDismiss,
  }) {
    _realDismissDialog();
    LoadingThemeData themeData = widget.themeData;
    tapDismiss ??= themeData.tapDismiss;
    LoadingTheme w = LoadingTheme(
      data: themeData.copyWith(
        tapDismiss: tapDismiss,
      ),
      child: LoadingWidget(
        key: loadingKey,
        loadingWidgetBuilder: (_, __) => loadingWidget,
      ),
    );
    OverlayEntry entry = OverlayEntry(builder: (BuildContext context) {
      return w;
    });

    overlayKey.currentState?.insert(entry);

    LoadingDismissFuture future =
        LoadingDismissFuture(entry, loadingKey, themeData.animDuration);
    return future;
  }

  void _realDismissDialog() {
    FutureManager.getInstance().dismissAll(false);
  }

  void dismissLoading() {
    _realDismissDialog();
  }
}

Future<LoadingDismissFuture?> showLoadingDialog({
  bool? tapDismiss,
}) {
  Completer<LoadingDismissFuture?> completer = Completer<LoadingDismissFuture?>();
  Future.delayed(Duration.zero, () {
    if (_keys.isNotEmpty) {
      GlobalKey<_LoadingProviderState> key = _keys.first;
      completer.complete(key.currentState?.showLoading(tapDismiss: tapDismiss));
    }
  });
  return completer.future;
}

Future<LoadingDismissFuture> showCustomLoadingWidget(
  Widget widget, {
  bool? tapDismiss,
}) {
  LoadLogHelper.log("show custom loading dialog");
  Completer<LoadingDismissFuture> completer = Completer<LoadingDismissFuture>();
  Future.delayed(Duration.zero, () {
    if (_keys.isNotEmpty) {
      GlobalKey<_LoadingProviderState> key = _keys.first;
      completer.complete(key.currentState?.showLoadingWidget(
        widget,
        tapDismiss: tapDismiss,
      ));
    }
  });
  return completer.future;
}

void hideLoadingDialog() {
  Future.delayed(Duration.zero, () {
    if (_keys.isNotEmpty) {
      GlobalKey<_LoadingProviderState> key = _keys.first;
      key.currentState?.loadingKey.currentState?.dismissAnim();
      key.currentState?.dismissLoading();
    }
  });
}
