import 'package:flutter/material.dart';
import 'package:banzai/app/core/services/authService.dart';
import 'package:banzai/app/data/models/user.dart' as model;
import 'package:banzai/app/core/utils/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get errorMessage => _errorMessage;

  Future<void> checkLoginStatus() async {
    final user = _authService.getCurrentUser();
    _setLoggedIn(user != null);
  }

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

  Future<bool> login(String email, String senha) async {
    final erroEmail = Validators.validarEmail(email);
    final erroSenha = Validators.validarSenha(senha);
    if (erroEmail != null || erroSenha != null) {
      _setError(erroEmail ?? erroSenha!);
      return false;
    }

    _setLoading(true);
    _setError(null);

    try {
      final user = model.User();
      user.email = email;
      user.senha = senha;

      await _authService.login(user);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      _setLoggedIn(true);

      return true;
    } catch (e) {
      _setError("Erro no login: ${e.toString()}");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register(String name, String email, String senha, String confirmarSenha) async {
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

    try {
      final user = model.User();
      user.name = name;
      user.email = email;
      user.senha = senha;

      await _authService.register(user);
      _setLoggedIn(true);
      return true;
    } catch (e) {
      _setError("Erro no cadastro: ${e.toString()}");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {

    await _authService.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    _setLoggedIn(false);
    notifyListeners();
  }

  Future<void> loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    _setLoggedIn(loggedIn);
  }

}
