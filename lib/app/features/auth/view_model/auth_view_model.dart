import 'package:banzai_novo/app/core/constants/appText.dart';
import 'package:flutter/material.dart';
import 'package:banzai_novo/app/core/services/authService.dart';
import 'package:banzai_novo/app/data/models/user.dart' as model;
import 'package:banzai_novo/app/core/utils/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banzai_novo/app/core/constants/appColors.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _userName;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get errorMessage => _errorMessage;
  String? get userName => _userName;


  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }


  Future<void> carregarNomeUsuario() async {
    final user = await _authService.getUserData();
    if (user != null) {
      _userName = user.name;
      notifyListeners();
    }
  }


  Future<void> _mostrarDialogoCarregamento(BuildContext context, String texto) async {
    await Future.delayed(Duration.zero);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(texto),
          ],
        ),
      ),
    );
  }

  Future<void> _mostrarDialogoSucesso(BuildContext context, String msg) async{
    await Future.delayed(Duration.zero);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 50),
              const SizedBox(height: 20),
              Text(msg),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Continuar")
            ),

          ],
        );
      },
    );
  }

  void _fecharDialogo(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _mostrarErro(BuildContext context, String mensagem) {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
              "Erro",
            style: AppText.Heading2.copyWith(color: AppColors.red),
          ),
          content: Text(mensagem, style: AppText.Body1.copyWith(color: AppColors.red),),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                  "Fechar",
                style: AppText.Button1.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<bool> login(BuildContext context, String email, String senha) async {
    final erroEmail = Validators.validarEmail(email);
    final erroSenha = Validators.validarSenha(senha);
    if (erroEmail != null || erroSenha != null) {
      _setError(erroEmail ?? erroSenha!);
      return false;
    }

    _setError(null);
    _setLoading(true);

    await _mostrarDialogoCarregamento(context, "Entrando...");
    bool sucesso = false;

    try {
      final user = model.User()
        ..email = email
        ..senha = senha;

      await _authService.login(user);
      await carregarNomeUsuario();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      _setLoggedIn(true);
      sucesso = true;
    } catch (e) {
      const erro = "Login ou senha incorretos, verifique e tente novamente";
      _setError(erro);
      _mostrarErro(context, erro);
    } finally {
      _fecharDialogo(context);
      _setLoading(false);
    }

    return sucesso;
  }

  Future<bool> register(BuildContext context, String name, String email, String senha, String confirmarSenha) async {
    final erroNome = Validators.validarNome(name);
    final erroEmail = Validators.validarEmail(email);
    final erroSenha = Validators.validarSenha(senha);
    final erroConfirmacao = Validators.validarConfirmacaoSenha(senha, confirmarSenha);

    if (erroNome != null || erroEmail != null || erroSenha != null || erroConfirmacao != null) {
      _setError(erroNome ?? erroEmail ?? erroSenha ?? erroConfirmacao!);
      return false;
    }

    _setLoading(true);
    _setError(null);

    await _mostrarDialogoCarregamento(context, "Criando conta...");
    bool sucesso = false;

    try {
      final user = model.User()
        ..name = name
        ..email = email
        ..senha = senha;

      await _authService.register(user);
      await carregarNomeUsuario();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      _setLoggedIn(true);
      sucesso = true;

    } catch (e) {
      const erro = "E-mail já em uso";
      _setError(erro);
      _mostrarErro(context, erro);
    } finally {
      _fecharDialogo(context);
      _setLoading(false);
    }

    return sucesso;
  }

  Future<bool> changePwd(BuildContext context, String email) async {
    final erroEmail = Validators.validarEmail(email);

    if (erroEmail != null) {
      _mostrarErro(context, erroEmail);
      return false;
    }

    _setLoading(true);
    await _mostrarDialogoCarregamento(context, "Enviando e-mail...");

    try {
      final user = model.User()..email = email;
      await _authService.forgotPwd(user);

      _fecharDialogo(context);
      _mostrarDialogoSucesso(context, "E-mail enviado com sucesso, confira a caixa de spam.");

      return true;
    } catch (e) {
      const erro = "Erro ao enviar link de recuperação.";
      _fecharDialogo(context);
      _setError(erro);
      _mostrarErro(context, erro);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> loginGoogle(BuildContext context) async {
    _setError(null);
    _setLoading(true);
    await _mostrarDialogoCarregamento(context, "Entrando com Google...");

    bool sucesso = false;

    try {
      await _authService.loginGoogle();
      await carregarNomeUsuario();

      final user = _authService.getCurrentUser();
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        _setLoggedIn(true);
        sucesso = true;
      } else {
        const erro = "Erro inesperado ao autenticar com Google.";
        _setError(erro);
        _mostrarErro(context, erro);
      }
    } catch (e) {
      const erro = "Erro ao entrar com o Google. Tente novamente.";
      _setError(erro);
      _mostrarErro(context, erro);
    } finally {
      _fecharDialogo(context);
      _setLoading(false);
    }

    return sucesso;
  }


  Future<void> logout(BuildContext context) async {
    _setLoading(true);
    await _mostrarDialogoCarregamento(context, "Saindo...");

    try {
      await _authService.logout();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      _setLoggedIn(false);
    } catch (e) {
      final erro = "Erro ao sair: ${e.toString()}";
      _setError(erro);
      _mostrarErro(context, erro);
    } finally {
      _fecharDialogo(context);
      _setLoading(false);
    }
  }

  Future<void> loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    _setLoggedIn(loggedIn);

    if (loggedIn) {
      await carregarNomeUsuario();
    }
  }

  Future<void> checkLoginStatus() async {
    final user = _authService.getCurrentUser();
    final isLogged = user != null;
    _setLoggedIn(isLogged);

    if (isLogged) {
      await carregarNomeUsuario();
    }
  }



}