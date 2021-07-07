import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_seed/app/core/core.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {

  @action
  void notification() {
    showNotifier(
      "Sucesso!",
      animationCurve: Curves.decelerate,
      duration: Duration(seconds: 3),
      position: NotifierPosition.bottom,
      backgroundColor: Color(0xFFEE507A),
      radius: 13.0,
      icon: Icon(Icons.check),
      textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
    );
  }

  @action
  Future<void> init() async {
    showLoadingDialog();
    Future.delayed(const Duration(seconds: 2), () {
      hideLoadingDialog();
      showNotifier(
        "Notificado! ",
        animationCurve: Curves.decelerate,
        duration: Duration(seconds: 3),
        position: NotifierPosition.bottom,
        backgroundColor: Color(0xFFEE507A),
        radius: 13.0,
        icon: Icon(Icons.check),
        textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
        // animationBuilder: Miui10AnimBuilder(),
      );
    });
  }
}
