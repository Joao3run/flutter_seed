import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.lazySingleton((i) => SplashController()),
  ];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute('/',
    //     child: (_, __) => SplashPage(), transition: TransitionType.fadeIn),
    // ModuleRoute('/home',
    //     module: HomeModule(), transition: TransitionType.fadeIn),
  ];
}
