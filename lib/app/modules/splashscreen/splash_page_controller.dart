import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_seed/app/core/core.dart';
import 'package:mobx/mobx.dart';

part 'splash_page_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  @observable
  bool loading = false;

  set setLoading(bool value) {
    loading = value;
  }

  void redirectToHome() {
    print('DIRECIONADNO para HOME');
    Modular.to.pushReplacementNamed(AppRoutes.home);
  }

  @action
  void init() {
    Timer(
      Duration(seconds: 2),
      () {
        redirectToHome();
      },
    );
  }
}
