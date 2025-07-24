import 'package:banzai_novo/app/core/constants/appColors.dart';
import 'package:banzai_novo/app/core/constants/appText.dart';
import 'package:banzai_novo/app/core/constants/responsive.dart';
import 'package:banzai_novo/app/core/constants/spacing.dart';
import 'package:banzai_novo/app/core/utils/validators.dart';
import 'package:banzai_novo/app/core/widgets/appLink.dart';
import 'package:banzai_novo/app/core/widgets/button.dart';
import 'package:banzai_novo/app/core/widgets/formInput.dart';
import 'package:banzai_novo/app/features/auth/view_model/auth_view_model.dart';
import 'package:banzai_novo/routes/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _logarUsuario(BuildContext context) async {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);

    final email = _emailController.text.toLowerCase().trim();
    final senha = _passwordController.text;

    final resultado = await authVM.login(context, email, senha);

    if (resultado == true) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    }
  }

  Future<void> _logarGoogle(BuildContext context) async {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);

    final resultado = await authVM.loginGoogle(context);

    if (resultado == true) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
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
                    padding: const EdgeInsets.only(top: Spacing.SpacingP),
                    child: Text(
                      "Bem-vindo ao Banzai",
                      style: AppText.Heading1.copyWith(color: AppColors.primary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.SpacingPP),
                    child: Text(
                      "Insira o e-mail e a senha para continuar",
                      style: AppText.Body1.copyWith(color: AppColors.grey),
                    ),
                  ),
                  Form(
                    key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: Spacing.SpacingM),
                            child: FormInput(
                              icon: const Icon(Icons.email),
                              title: "E-mail",
                              hint: "Insira seu email",
                              controller: _emailController,
                              validator: Validators.validarEmail,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: Spacing.SpacingM),
                            child: FormInput(
                              icon: const Icon(Icons.lock),
                              title: "Senha",
                              obscure: true,
                              hint: "Insira sua senha",
                              controller: _passwordController,
                              validator: Validators.validarSenha,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: Spacing.SpacingGG),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: AppLink(
                                title: "Esqueceu a senha?",
                                func: () {
                                  Navigator.pushReplacementNamed(context, "/forgot");
                                },
                              ),
                            ),
                          ),
                        AppButton(
                            title: "Login",
                            onPressed: () {
                              if (_formKey.currentState!.validate()){
                                _logarUsuario(context);
                              }
                            },
                          ),
                          const SizedBox(height: Spacing.SpacingP),
                          AppButton(
                            image: "assets/images/logo_google.png",
                            primary: false,
                            title: "Entrar com o Google",
                            onPressed: () {
                              _logarGoogle(context);
                            },
                          ),
                        ],
                      ) ,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.SpacingXG),
                    child: Text(
                      "Ainda não possui conta?",
                      style: AppText.Body1.copyWith(color: AppColors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.SpacingPP),
                    child: AppLink(
                      title: "Criar nova conta",
                      func: () {
                        Navigator.pushNamed(context, Routes.cadastro);
                      },
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
