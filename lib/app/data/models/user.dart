class User {
  String _idUser = "";
  String _name = "";
  String _email = "";
  String _senha = "";
  String _confirmarSenha = "";

  User({
    String idUser = "",
    String name = "",
    String email = "",
    String senha = "",
    String confirmarSenha = "",
  })  : _idUser = idUser,
        _name = name,
        _email = email,
        _senha = senha,
        _confirmarSenha = confirmarSenha;

  String get idUser => _idUser;
  set idUser(String value) {
    _idUser = value;
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String get senha => _senha;
  set senha(String value) {
    _senha = value;
  }

  String get confirmarSenha => _confirmarSenha;
  set confirmarSenha(String value) {
    _confirmarSenha = value;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUser": _idUser,
      "name": _name,
      "email": _email,
    };
    return map;
  }


}
