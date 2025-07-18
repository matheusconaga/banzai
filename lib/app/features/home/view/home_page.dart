import 'package:banzai/app/core/widgets/button.dart';
import 'package:banzai/app/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("AppBAR"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Logado com sucesso!"),
            AppButton(
              title: "Deslogar",
              onPressed: () async {
                await authViewModel.logout();
                Navigator.pushReplacementNamed(context, "/");
              },
            ),
          ],
        ),
      ),
    );
  }
}
