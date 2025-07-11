import 'package:banzai/styles/appColors.dart';
import 'package:banzai/styles/appText.dart';
import 'package:banzai/styles/spacing.dart';
import 'package:banzai/widgets/button.dart';
import 'package:banzai/widgets/formInput.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo_banzai.png",
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                  height: Spacing.SpacingP,
                ),
                Text(
                  "Bem-vindo ao Banzai",
                  style: AppText.Heading1.copyWith(color: AppColors.hoverPrimary),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Spacing.SpacingXP),
                  child: Text(
                    "Insira o e-mail e a senha para continuar",
                    style: AppText.Body1.copyWith(color: AppColors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Spacing.SpacingP),
                  child: FormInput(
                    icon: Icon(Icons.email),
                    title: "Email",
                    hint: "Insira seu email",
                    controller: _emailController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Spacing.SpacingM),
                  child: FormInput(
                    icon: Icon(Icons.lock),
                    title: "Senha",
                    obscure: true,
                    hint: "Insira sua senha",
                    controller: _passwordController,
                  ),
                ),
                SizedBox(
                  height: Spacing.SpacingGG,
                ),
                AppButton(
                  title: "Login",
                  onPressed: (){
                    print("Ola");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
