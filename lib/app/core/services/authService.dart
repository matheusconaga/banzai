import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:banzai_novo/app/data/models/user.dart' as model;
import 'package:google_sign_in/google_sign_in.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

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

  Future<model.User?> getUserData() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return null;

      final doc = await _db.collection("usuarios").doc(currentUser.uid).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return model.User(
          idUser: data['idUser'],
          name: data['name'],
          email: data['email'],
        );
      }

      return null;
    } catch (e) {
      print("Erro ao buscar dados do usuário: $e");
      return null;
    }
  }


  Future<void> loginGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception("Login cancelado pelo usuário");
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        final userDoc = await _db.collection("usuarios").doc(firebaseUser.uid).get();

        if (!userDoc.exists) {
          final newUser = model.User(
            idUser: firebaseUser.uid,
            name: firebaseUser.displayName ?? googleUser.displayName ?? "",
            email: firebaseUser.email ?? googleUser.email ?? "",
          );

          await _db.collection("usuarios").doc(firebaseUser.uid).set(newUser.toMap());
        }
      }
    } catch (e) {
      print("Erro no login com Google: $e");
      rethrow;
    }
  }




  Future<void> forgotPwd(model.User user) async{
    try {
      await _auth.sendPasswordResetEmail(email: user.email);
    } catch (e){
      print("Erro ao enviar email: $e");
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

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {
    }
    await _auth.signOut();
  }

}