import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_seed/app/core/core.dart';
import 'package:flutter_seed/app/modules/home/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
              icon: Icon(Icons.download_outlined),
              onPressed: () {
                controller.init();
              }),
          IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                controller.notification();
              }),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.helloWord,
                style: AppTextStyles.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
