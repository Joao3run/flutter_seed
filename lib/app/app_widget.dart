import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_seed/app/shared/core/core.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Seed',
      theme: ThemeData(
        primaryColor: AppColors.darkRed,
      ),
      initialRoute: AppRoutes.base,
    ).modular();
  }
}
