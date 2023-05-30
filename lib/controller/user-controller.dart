// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings, unused_import, unused_local_variable

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
    //recuperarNomeEmpresa(userId.toString());
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

void newUser(BuildContext context, Users user) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  await auth
      .createUserWithEmailAndPassword(email: user.email, password: user.senha)
      .then((firebaseUser) {
    final SnackBar snackBar = SnackBar(
        content: Text('Usuário cadastrado com sucesso'),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.primaryColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //Navigator.of(context).pushNamed('/user-login');
    userId = auth.currentUser?.uid;
    print('userId' + userId.toString());

    newUserDocument(context, user, userId.toString());
    //return teste;
  }).catchError((e) {
    final SnackBar snackBar = SnackBar(
      content: Text("Erro ao cadastrar cliente " + e.toString()),
      duration: Duration(seconds: 5),
      backgroundColor: AppColors.textColorRed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
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

void updateUser(BuildContext context, String idUser, Users user) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    await db.collection("users").doc(idUser).update({
      "nomeEmpresa": user.nomeEmpresa,
      "nome": user.nome,
      "telefone": user.telefone
      //"status": user.status
    });
  } catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao atualizar usuário " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void deleteUser(BuildContext context, String idUser) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    await db.collection("users").doc(idUser).update({"status": false});
  } catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao inativar usuário " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
