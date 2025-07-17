class User{

  String _idUser = "";
  String _name = "";
  String _email = "";
  String _senha = "";
  String _confirmarSenha = "";

  User();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUser": this._idUser,
      "name": this._name,
      "email": this._email,
    };

    return map;

  }

  String get confirmarSenha => _confirmarSenha;

  set confirmarSenha(String value) {
    _confirmarSenha = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get idUser => _idUser;

  set idUser(String value) {
    _idUser = value;
  }

}