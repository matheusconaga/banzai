import 'package:banzai/app/core/constants/appColors.dart';
import 'package:banzai/app/core/constants/appText.dart';
import 'package:banzai/app/core/constants/responsive.dart';
import 'package:banzai/app/core/constants/spacing.dart';
import 'package:banzai/app/core/widgets/appLink.dart';
import 'package:banzai/app/core/widgets/button.dart';
import 'package:banzai/app/core/widgets/formInput.dart';
import 'package:banzai/app/features/auth/view_model/auth_view_model.dart';
import 'package:banzai/routes/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}


class _AuthState extends State<Auth> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _logarUsuario(BuildContext context) async {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);

    final email = _emailController.text.toLowerCase().trim();
    final senha = _passwordController.text;

    final resultado = await authVM.login(email, senha);

    if (resultado == true) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "/home");
    }
  }


  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: Responsive.width(context) * 0.8,
              color: AppColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo_banzai.png",
                    width: 100,
                    height: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.SpacingP),
                    child: Text(
                      "Bem-vindo ao Banzai",
                      style: AppText.Heading1.copyWith(color: AppColors.primary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.SpacingPP),
                    child: Text(
                      "Insira o e-mail e a senha para continuar",
                      style: AppText.Body1.copyWith(color: AppColors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.SpacingM),
                    child: FormInput(
                      icon: Icon(Icons.email),
                      title: "E-mail",
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Spacing.SpacingGG),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AppLink(
                        title: "Esqueceu a senha?",
                        func: () {
                          print("Esqueci");
                        },
                      ),
                    ),
                  ),
                  authVM.isLoading
                      ? const CircularProgressIndicator()
                      : AppButton(
                    title: "Login",
                    onPressed: () => _logarUsuario(context),
                  ),
                  SizedBox(height: Spacing.SpacingP),
                  AppButton(
                    image: "assets/images/logo_google.png",
                    primary: false,
                    title: "Entrar com o Google",
                    onPressed: () {
                      // Google login ainda não implementado
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.SpacingXG),
                    child: Text(
                      "Ainda não possui conta?",
                      style: AppText.Body1.copyWith(color: AppColors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.SpacingPP),
                    child: AppLink(
                      title: "Criar nova conta",
                      func: () {
                        Navigator.pushNamed(context, Routes.cadastro);
                      },
                    ),
                  ),
                  if (authVM.errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(top: Spacing.SpacingPP),
                      child: Text(
                        authVM.errorMessage!,
                        style: const TextStyle(
                          color: AppColors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
