import 'package:banzai/styles/appColors.dart';
import 'package:banzai/styles/appText.dart';
import 'package:banzai/styles/responsive.dart';
import 'package:banzai/styles/spacing.dart';
import 'package:banzai/widgets/appLink.dart';
import 'package:banzai/widgets/button.dart';
import 'package:banzai/widgets/formInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                      "Crie sua conta para poder gerenciar seus projetos",
                      textAlign: TextAlign.center,
                      style: AppText.Body1.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.SpacingM),
                    child: FormInput(
                      icon: Icon(Icons.person),
                      title: "Nome",
                      hint: "Insira seu nome",
                      controller: _nameController,
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
                    padding: EdgeInsets.only(top: Spacing.SpacingM, bottom: Spacing.SpacingGG),
                    child: FormInput(
                      icon: Icon(Icons.lock),
                      title: "Confirmar senha",
                      obscure: true,
                      hint: "Insira sua senha novamente",
                      controller: _confirmPasswordController,
                    ),
                  ),
                  AppButton(
                    title: "Criar conta",
                    onPressed: (){
                      print("Ola");
                    },
                  ),
                  SizedBox(
                    height: Spacing.SpacingP,
                  ),
                  AppButton(
                      image: "assets/images/logo_google.png",
                      primary: false,
                      title: "Criar com o Google",
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
                      title: "Entrar na conta",
                      func: (){
                        Navigator.pop(context);
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
