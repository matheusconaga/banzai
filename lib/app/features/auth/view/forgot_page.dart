import 'package:banzai_novo/app/core/constants/appColors.dart';
import 'package:banzai_novo/app/core/constants/appText.dart';
import 'package:banzai_novo/app/core/constants/responsive.dart';
import 'package:banzai_novo/app/core/constants/spacing.dart';
import 'package:banzai_novo/app/core/utils/validators.dart';
import 'package:banzai_novo/app/core/widgets/appLink.dart';
import 'package:banzai_novo/app/core/widgets/button.dart';
import 'package:banzai_novo/app/core/widgets/formInput.dart';
import 'package:banzai_novo/app/features/auth/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future <void> _forgotPwd(BuildContext context) async{
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    final email = _emailController.text.toLowerCase().trim();

    final resultado = await authVM.changePwd(context, email);

    if (resultado == true) {
      Navigator.pushReplacementNamed(context, "/login");
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
                    padding: const EdgeInsets.only(top: Spacing.SpacingP),
                    child: Text(
                      "Recuperar Conta",
                      style:
                          AppText.Heading1.copyWith(color: AppColors.primary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.SpacingPP),
                    child: Text(
                      "Insira o e-mail e enviaremos um link para recuperar sua conta",
                      textAlign: TextAlign.center,
                      style: AppText.Body1.copyWith(color: AppColors.grey),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: Spacing.SpacingM, bottom: Spacing.SpacingG),
                          child: FormInput(
                            icon: const Icon(Icons.email),
                            title: "E-mail",
                            hint: "Insira seu email",
                            controller: _emailController,
                            validator: Validators.validarEmail,
                          ),
                        ),
                        AppButton(
                          title: "Enviar link de recuperação",
                          onPressed: () {
                            if (_formKey.currentState!.validate()){
                              _forgotPwd(context);
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: Spacing.SpacingXG),
                          child: AppLink(
                            title: "Voltar pro Login",
                            func: () {
                              Navigator.pushReplacementNamed(context, "/login");
                            },
                          ),
                        ),
                      ],
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
