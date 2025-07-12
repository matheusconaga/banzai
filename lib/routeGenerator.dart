import 'package:flutter/material.dart';
import 'package:banzai/pages/auth.dart';
import 'package:banzai/pages/createAccount.dart';
import 'package:banzai/pages/home.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
  static const String login = "/";
  static const String cadastro = "/cadastro";
  static const String home = "/home";

}