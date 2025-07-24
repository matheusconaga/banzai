import 'package:banzai_novo/app/core/constants/appColors.dart';
import 'package:banzai_novo/app/core/constants/appText.dart';
import 'package:banzai_novo/app/core/widgets/button.dart';
import 'package:banzai_novo/app/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    final String? _name = authVM.userName;

    return Scaffold(
      appBar: AppBar(
        title: const Text("AppBAR"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Logado com sucesso!"),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 "Bem-vindo, ",
                 style: AppText.Heading2.copyWith(color: AppColors.primary),
               ),
               Text(
                 _name ?? "Usuário sem nome",
                 style: AppText.Heading2.copyWith(color: AppColors.blue),
               ),
             ],
           ),
            AppButton(
              title: "Deslogar",
              onPressed: () async {
                await authVM.logout(context);
                Navigator.pushReplacementNamed(context, "/");
              },
            ),
          ],
        ),
      ),
    );
  }
}
