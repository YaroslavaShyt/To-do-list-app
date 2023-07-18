import 'package:taskapp/screens/tabs/start_screen.dart';

import '../screens/login_screen/forgot_password_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/login_screen/register_screen.dart';
import 'package:flutter/material.dart';
import '../screens/recycle_bin_screen/recycle_bin.dart';
import '../screens/tabs/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(
          builder: (_) => const RecycleBin(),
        );
      case TabsScreen.id:
        return MaterialPageRoute(
          builder: (_) => const TabsScreen(),
        );
      case RegisterScreen.id:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case LoginScreen.id:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case ForgotPasswordScreen.id:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case StartScreen.id:
        return MaterialPageRoute(
          builder: (_) => const StartScreen(),
        );
      default:
        return null;
    }
  }
}
