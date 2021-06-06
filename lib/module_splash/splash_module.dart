import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/abstracts/module/yes_module.dart';
import 'package:pasco_shipping/module_splash/splash_routes.dart';
import 'package:pasco_shipping/module_splash/ui/screen/splash_screen.dart';

@injectable
class SplashModule extends YesModule {
  SplashModule(SplashScreen splashScreen) {
    YesModule.RoutesMap.addAll({
      SplashRoutes.SPLASH_SCREEN: (context) => splashScreen
    });
  }
}