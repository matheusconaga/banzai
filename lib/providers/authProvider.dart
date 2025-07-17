import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider{

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;


}
