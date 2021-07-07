import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_seed/app/modules/home/home_page.dart';

import 'home_controller.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.lazySingleton((i) => NavbarController()),
    Bind.lazySingleton((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
  ];
}
