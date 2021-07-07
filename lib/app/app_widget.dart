import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_seed/app/core/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Seed',
      localizationsDelegates: [
        AppLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('pt', ''),
      ],
      theme: ThemeData(
        primaryColor: AppColors.darkRed,
      ),
      initialRoute: AppRoutes.base,
    ).modular();
  }
}
