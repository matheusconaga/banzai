import 'package:banzai/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> register(model.User user) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: user.email,
          password: user.senha,
      );

      String uid = userCredential.user!.uid;
      user.idUser = uid;
      await _db.collection("usuarios").doc(uid).set(user.toMap());

    }catch (e) {
      print("Erro no cadastro: $e");
      rethrow;
    }
  }

  Future<void> login(model.User user) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.senha,
      );
    } catch (e) {
      print("Erro no login: $e");
      rethrow;
    }
  }

  Future<void> logout() async{
    await _auth.signOut();
  }

}