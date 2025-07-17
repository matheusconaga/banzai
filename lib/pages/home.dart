import 'package:banzai/services/authService.dart';
import 'package:banzai/widgets/button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  final AuthService _authService = AuthService();

  _deslogar() async {
    await _authService.logout();
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBAR"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Logado"),
            ),
            AppButton(
                title: "Deslogar",
                onPressed: _deslogar,
            ),
          ],
        ),
      ),
    );
  }
}
