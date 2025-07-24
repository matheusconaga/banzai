import 'package:banzai_novo/app/core/constants/appColors.dart';
import 'package:banzai_novo/app/core/constants/appText.dart';
import 'package:banzai_novo/app/core/constants/responsive.dart';
import 'package:banzai_novo/app/core/constants/spacing.dart';
import 'package:banzai_novo/app/core/widgets/appLink.dart';
import 'package:banzai_novo/app/core/widgets/button.dart';
import 'package:banzai_novo/app/core/widgets/formInput.dart';
import 'package:banzai_novo/app/core/utils/validators.dart';
import 'package:banzai_novo/app/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final _formKey = GlobalKey<FormState>();
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

    final resultado = await authVM.register(context ,name, email, senha, confirmarSenha);

    if (!resultado) {
      setState(() {
        _mensagemErro = authVM.errorMessage ?? "";
      });
    } else {
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
                  Image.asset("assets/images/logo_banzai.png", width: 100, height: 100),
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
                      "Crie sua conta para poder gerenciar seus projetos",
                      textAlign: TextAlign.center,
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
                              icon: const Icon(Icons.person),
                              title: "Nome",
                              hint: "Insira seu nome",
                              controller: _nameController,
                              validator: Validators.validarNome,
                            ),
                          ),
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
                            padding: const EdgeInsets.only(top: Spacing.SpacingM, bottom: Spacing.SpacingGG),
                            child: FormInput(
                              icon: const Icon(Icons.lock),
                              title: "Confirmar senha",
                              obscure: true,
                              hint: "Insira sua senha novamente",
                              controller: _confirmPasswordController,
                              validator: (_) => Validators.validarConfirmacaoSenha(
                            _passwordController.text,
                            _confirmPasswordController.text,
                          ),
                            ),
                          ),
                          AppButton(
                            title: "Criar conta",
                            onPressed: (){
                              if (_formKey.currentState!.validate()){
                                _cadastrarUsuario(context);
                              }
                            }
                          ),

                        ],
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.SpacingXG),
                    child: Text(
                      "Já possui conta?",
                      style: AppText.Body1.copyWith(color: AppColors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.SpacingPP),
                    child: AppLink(
                      title: "Entrar na conta",
                      func: () => Navigator.pop(context),
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
