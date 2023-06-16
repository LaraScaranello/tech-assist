// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings, unused_import, unused_local_variable, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_assist/main.dart';
import 'package:tech_assist/model/users.dart';
import 'package:tech_assist/utils/appColors.dart';

// método para efetuar o login no firebase
void efetuaLogin(BuildContext context, Users user) async {
  // instanciar o firebase auth (autenticação)
  FirebaseAuth auth = FirebaseAuth.instance;

  // método para realizar o login com email e senha
  await auth
      .signInWithEmailAndPassword(email: user.email, password: user.senha)
      .then((firebaseUser) {
    userId = auth.currentUser?.uid;
    final SnackBar snackBar = SnackBar(
        content: Text("Login efetuado com sucesso"),
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.primaryColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pushNamed('/main-page');
  }).catchError((error) {
    final SnackBar snackBar = SnackBar(
      content: Text("Email ou senha inválidos!"),
      duration: Duration(seconds: 3),
      backgroundColor: AppColors.textColorRed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}

String erro = '';
void newUser(BuildContext context, Users user) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    await auth
        .createUserWithEmailAndPassword(email: user.email, password: user.senha)
        .then((firebaseUser) {
      final SnackBar snackBar = SnackBar(
          content: Text('Usuário cadastrado com sucesso'),
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.primaryColor);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      userId = auth.currentUser?.uid;
      newUserDocument(context, user, userId.toString());
    });
  } catch (e) {
    if (e.toString().contains('firebase_auth/email-already-in-use')) {
      erro = "O endereço de e-mail já está sendo usado";
    }
    final SnackBar snackBar = SnackBar(
      content: Text("Erro ao cadastrar cliente \n" + erro),
      duration: Duration(seconds: 5),
      backgroundColor: AppColors.textColorRed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void newUserDocument(BuildContext context, Users user, String idRetorno) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  String idFinal = '';

  if (idRetorno != null) {
    idFinal = idRetorno;
  }
  if (userId != null) {
    idFinal = userId.toString();
  }

  try {
    await db.collection("users").add({
      'idUser': idFinal,
      'nomeEmpresa': user.nomeEmpresa,
      'nome': user.nome,
      'telefone': user.telefone,
      'email': user.email,
      'senha': user.senha
    });
    Navigator.of(context).pushNamed('/main-page');
  } catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao cadastrar usuário " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void updateUser(BuildContext context, String idUser, String nomeEmpresa,
    String nome, String telefone) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot =
        await usersRef.where('idUser', isEqualTo: idUser).get();

    querySnapshot.docs.forEach((doc) {
      usersRef.doc(doc.id).update(
          {"nomeEmpresa": nomeEmpresa, "nome": nome, "telefone": telefone});
    });

    final SnackBar snackBar = SnackBar(
        content: Text("Usuário atualizado com sucesso"),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.primaryColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao atualizar usuário " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// função para excluir a conta do usuário
void deleteUser(BuildContext context) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = _auth.currentUser;

  if (user != null) {
    try {
      await user.delete();
      final SnackBar snackBar = SnackBar(
          content: Text("Usuário excluído com sucesso"),
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.primaryColor);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
      Navigator.of(context).pushNamed('/user-login');
    } catch (e) {}
  }
}

Future resetPassword(BuildContext context, String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    final SnackBar snackBar = SnackBar(
        content: Text("E-mail enviado com sucesso"),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.primaryColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao enviar o e-amil " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
