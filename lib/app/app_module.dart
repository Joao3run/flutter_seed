import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_seed/app/modules/home/home_module.dart';
import 'package:flutter_seed/app/modules/splashscreen/splash_page.dart';
import 'package:flutter_seed/app/modules/splashscreen/splash_page_controller.dart';
import 'package:flutter_seed/app/core/app/app_routes.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.base,
        child: (_, __) => SplashPage(), transition: TransitionType.fadeIn),
    ModuleRoute(AppRoutes.home,
        module: HomeModule(), transition: TransitionType.fadeIn),
  ];
}
