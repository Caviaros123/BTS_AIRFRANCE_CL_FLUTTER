// import 'package:finpay/bindings/init_binding.dart';
// import 'package:finpay/services/auth_guard.dart';
// import 'package:finpay/view/login/login_screen.dart';
// import 'package:finpay/view/profile/profile_view.dart';
// import 'package:finpay/view/signup/signup_screen.dart';
// import 'package:finpay/view/splash/splash.dart';
// import 'package:finpay/view/splash/welcome_screen.dart';
// import 'package:finpay/view/tab_screen.dart';
import 'package:airfrance/views/home.dart';
import 'package:airfrance/views/profil/profil_view.dart';
import 'package:get/get.dart';

import '../bindings/init_bindings.dart';
import '../views/aeroports/aeroports_view.dart';

class AppPages {
  AppPages._();

  static get INITIAL => Routes.home;

  static final appPages = [
    GetPage(
      name: Routes.profile,
      page: () => ProfileView(),
      binding: InitBindings(),
      middlewares: [
        // IsFirstOpen(),
        // RequireVisitor()
      ],
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: InitBindings(),
      middlewares: [
        // IsFirstOpen(),
        // RequireVisitor()
      ],
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.airports,
      page: () => AeroportsView(),
      binding: InitBindings(),
      middlewares: [
        // IsFirstOpen(),
        // RequireVisitor()
      ],
      // binding: SplashScreenBinding(),
    ),
    /*GetPage(
      name: Routes.forgotPwd,
      page: () => ForgotPasswordScreen(),
      middlewares: [
        IsFirstOpen(),
        RequireVisitor()
      ],
    ),
    GetPage(
      name: Routes.resetPwd,
      page: () => ResetRecoveryOtpScreen(),
      middlewares: [
        RequireVisitor()
      ],
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.newPwd,
      page: () => ChangePasswordScreen(),
      middlewares: [
        IsFirstOpen(),
        RequireVisitor()
      ],
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      // binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.welcome,
      page: () => OnboardingScreen(),
      middlewares: [
        // RequireVisitor()
      ],
      // middlewares: [
      //   IsFirstGuard(),
      //   // My middlewares here
      //   AuthGuard(),
      // ],
    ),
    GetPage(
      name: Routes.home,
      page: () => const BottomNavigationBarPage(),
      binding: InitBindings(),
      middlewares: [
        AuthMiddlewares(),
      ],
    ),
    GetPage(
      name: Routes.signIn,
      page: () => SignInScreen(),
      middlewares: [
        IsFirstOpen(),
        RequireVisitor()
      ],
    ),
    GetPage(
      name: Routes.signUp,
      middlewares: [
        IsFirstOpen(),
        RequireVisitor()
      ],
      page: () => SignUpScreen(),
    ),*/
    // GetPage(
    //   name: Routes.profile,
    //   page: () => const ProfileView(),
    //   middlewares: [
    //     AuthGuard(),
    //   ],
    // ),
  ];
}

abstract class Routes {
  Routes._();

  static const home = '/home';
  static const newPwd = '/set-new-password';
  static const resetPwd = '/reset-password';
  static const forgotPwd = '/forgot-password';
  static const welcome = '/welcome';
  static const dashboard = '/dashboard';
  static const airports = '/airports';
  static const signIn = '/login';
  static const signUp = '/register';
  static const profile = '/profile';
  static const splashScreen = '/splashScreen';
}
