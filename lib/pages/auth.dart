import 'dart:io';

import 'package:banzai/controllers/authController.dart';
import 'package:banzai/pages/createAccount.dart';
import 'package:banzai/routeGenerator.dart';
import 'package:banzai/styles/appColors.dart';
import 'package:banzai/styles/appText.dart';
import 'package:banzai/styles/responsive.dart';
import 'package:banzai/styles/spacing.dart';
import 'package:banzai/utils/validators.dart';
import 'package:banzai/widgets/appLink.dart';
import 'package:banzai/widgets/button.dart';
import 'package:banzai/widgets/formInput.dart';
import 'package:flutter/material.dart';



class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  final AuthController _authController = AuthController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _mensagemErro = "";


  _logarUsuario() async{
    final email = _emailController.text.toLowerCase().trim();
    final senha = _passwordController.text;

    final erroEmail = Validators.validarEmail(email);
    final erroSenha = Validators.validarSenha(senha);

    if (erroEmail != null || erroSenha != null) {
      setState(() {
        _mensagemErro = erroEmail ?? erroSenha!;
      });
      return;
    }

    final resultado = await _authController.login(email, senha);
    if (resultado != null) {
      setState(() {
        _mensagemErro = resultado;
      });
    } else {
      Navigator.pushReplacementNamed(context, "/home");
    }

  }

  @override
  Widget build(BuildContext context) {
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
                  AppButton(
                    title: "Login",
                    onPressed: (){
                      _logarUsuario();
                    },
                  ),
                  SizedBox(
                    height: Spacing.SpacingP,
                  ),
                  AppButton(
                      image: "assets/images/logo_google.png",
                      primary: false,
                      title: "Entrar com o Google",
                      onPressed: (){

                      }
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
                      func: (){
                        Navigator.pushNamed(context, Routes.cadastro);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.SpacingPP),
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(
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
