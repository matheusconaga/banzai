import 'package:banzai/widgets/button.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APPBAR"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Este é o botão"),
            AppButton(

            ),
          ],
        ),
      ),
    );
  }
}
