import 'package:banzai_novo/app/core/widgets/splash_page.dart';
import 'package:banzai_novo/app/features/auth/view/forgot_page.dart';
import 'package:banzai_novo/app/features/auth/view/login_page.dart';
import 'package:banzai_novo/app/features/auth/view/register_page.dart';
import 'package:banzai_novo/app/features/home/view/home_page.dart';
import 'package:flutter/material.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const Auth());
      case Routes.cadastro:
        return MaterialPageRoute(builder: (_) => const CreateAccount());
      case Routes.forgot:
        return MaterialPageRoute(builder: (_) => const ForgotPage());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const Home());
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
  static const String forgot = "/forgot";

}