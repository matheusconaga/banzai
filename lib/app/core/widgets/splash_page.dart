import 'package:banzai_novo/app/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authVM = Provider.of<AuthViewModel>(context, listen: false);
      await authVM.checkLoginStatus();

      if (authVM.isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
