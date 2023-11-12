import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticator {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> signIn({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "invalid-login-credentials":
            return "Login ou senha inválidos.";
          default:
            return "Erro ao logar no aplicativo.";
        }
    }
    return null;
  }

  Future<String?> signUp({required String email, required String password, required String name}) async {
    try {
       UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "email-already-in-use":
            return "O e-mail já está cadastrado.";
          default:
            return "Erro ao tentar cadastrar usuário.";
        }
    }
    return null;
  }

  Future<String?> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException {
        return "Erro ao deslogar usuário.";
    }
    return null;
  }

}

snackbarError({required String message, required BuildContext context, bool erro = true}) {
  SnackBar snackbar = SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(message),
    backgroundColor: erro ? Colors.red : Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

snackbarOk({required String message, required BuildContext context}) {
  SnackBar snackbar = SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(message),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}