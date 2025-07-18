import 'package:banzai/app/core/constants/appColors.dart';
import 'package:banzai/app/core/constants/appText.dart';
import 'package:banzai/app/core/constants/responsive.dart';
import 'package:banzai/app/core/constants/spacing.dart';
import 'package:banzai/app/core/widgets/appLink.dart';
import 'package:banzai/app/core/widgets/button.dart';
import 'package:banzai/app/core/widgets/formInput.dart';
import 'package:banzai/app/core/utils/validators.dart';
import 'package:banzai/app/features/auth/view_model/auth_view_model.dart';
import 'package:banzai/routes/routeGenerator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  String _mensagemErro = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _cadastrarUsuario(BuildContext context) async {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);

    final name = _nameController.text.trim();
    final email = _emailController.text.toLowerCase().trim();
    final senha = _passwordController.text;
    final confirmarSenha = _confirmPasswordController.text;

    final erroNome = Validators.validarNome(name);
    final erroEmail = Validators.validarEmail(email);
    final erroSenha = Validators.validarSenha(senha);
    final erroConfirmacao = Validators.validarConfirmacaoSenha(senha, confirmarSenha);

    if (erroNome != null || erroEmail != null || erroSenha != null || erroConfirmacao != null) {
      setState(() {
        _mensagemErro = erroNome ?? erroEmail ?? erroSenha ?? erroConfirmacao!;
      });
      return;
    }

    final resultado = await authVM.register(name, email, senha, confirmarSenha);

    if (!resultado) {
      setState(() {
        _mensagemErro = authVM.errorMessage ?? "";
      });
    } else {
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
                  Image.asset("assets/images/logo_banzai.png", width: 100, height: 100),
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
                      style: AppText.Body1.copyWith(color: AppColors.grey),
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
                  authVM.isLoading
                      ? const CircularProgressIndicator()
                      : AppButton(
                    title: "Criar conta",
                    onPressed: () => _cadastrarUsuario(context),
                  ),
                  SizedBox(height: Spacing.SpacingP),
                  AppButton(
                    image: "assets/images/logo_google.png",
                    primary: false,
                    title: "Criar com o Google",
                    onPressed: () {
                      // Em breve
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.SpacingXG),
                    child: Text(
                      "Já possui conta?",
                      style: AppText.Body1.copyWith(color: AppColors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing.SpacingPP),
                    child: AppLink(
                      title: "Entrar na conta",
                      func: () => Navigator.pop(context),
                    ),
                  ),
                  if (authVM.errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(top: Spacing.SpacingPP),
                      child: Text(
                        authVM.errorMessage!,
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
