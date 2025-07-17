import 'package:banzai/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:banzai/models/user.dart' as model;


class AuthController{
  final AuthService _authService = AuthService();

  Future<String?> register(String name, String email, String senha) async {
    try {
      final user = model.User();
      user.email = email;
      user.senha = senha;
      user.name = name;

      await _authService.register(user);
      return null;
    } catch (e) {
      return "Erro no cadastro: ${e.toString()}";
    }
  }

  Future<String?> login(String email, String senha) async {
    try {
      final user = model.User();
      user.email = email;
      user.senha = senha;

      await _authService.login(user);
      return null;
    } catch (e) {
      return "Erro no cadastro: ${e.toString()}";
    }
  }





}