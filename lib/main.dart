import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_seed/app/app_module.dart';
import 'package:flutter_seed/app/core/core.dart';
import 'package:flutter_seed/app/core/widgets/notifier/notifier.dart';

import 'app/app_widget.dart';

void main() {
  runApp(
    Notifier(
      textStyle: TextStyle(fontSize: 19.0, color: Colors.white),
      backgroundColor: Colors.black,
      radius: 10.0,
      child: LoadingProvider(
        child: ModularApp(
          module: AppModule(),
          child: AppWidget(),
        ),
      ),
      animationCurve: Curves.elasticInOut,
      animationDuration: Duration(milliseconds: 200),
      duration: Duration(seconds: 3),
    ),
  );
}
