import 'package:get/get.dart';

import '../data/di.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/auth/splash/bindings/splash_binding.dart';
import '../modules/auth/splash/views/splash_view.dart';
import '../modules/auth/verification/bindings/verification_binding.dart';
import '../modules/auth/verification/views/verification_view.dart';
import '../modules/home/chat/bindings/chat_binding.dart';
import '../modules/home/chat/views/chat_view.dart';
import '../modules/home/homepage/bindings/homepage_binding.dart';
import '../modules/home/homepage/views/homepage_view.dart';
import '../modules/home/notification/bindings/notification_binding.dart';
import '../modules/home/notification/views/notification_view.dart';
import '../modules/home/map_gps/bindings/map_gps_binding.dart';
import '../modules/home/map_gps/views/map_gps_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    //* Auth
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fade,
      transitionDuration: $r.times.med,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.fade,
      transitionDuration: $r.times.med,
    ),
    GetPage(
      name: _Paths.VERIFICATION,
      page: () => const VerificationView(),
      binding: VerificationBinding(),
    ),

    //* Home
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => const HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.MAP_GPS,
      page: () => const MapGpsView(),
      binding: MapGpsBinding(),
    ),

    //* Chat
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
      transition: Transition.fade,
      transitionDuration: $r.times.fast,
    ),
  ];
}
