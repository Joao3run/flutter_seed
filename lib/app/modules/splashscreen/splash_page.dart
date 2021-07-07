import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_seed/app/modules/splashscreen/splash_page_controller.dart';
import 'package:flutter_seed/app/core/app/app_colors.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        color: AppColors.darkRed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!controller.loading)
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
          ],
        ),
      );
    });
  }
}
