import 'package:banzai/app/core/widgets/splash_page.dart';
import 'package:banzai/app/features/auth/view/login_page.dart';
import 'package:banzai/app/features/auth/view/register_page.dart';
import 'package:banzai/app/features/home/view/home_page.dart';
import 'package:flutter/material.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashPage:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => Auth());
      case Routes.cadastro:
        return MaterialPageRoute(builder: (_) => CreateAccount());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Tela não encontrada!"),
        ),
        body: const Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }
}

class Routes {
  static const String splashPage = "/";
  static const String login = "/login";
  static const String cadastro = "/cadastro";
  static const String home = "/home";

}