// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tech_assist/model/clients.dart';

void newClient(BuildContext context, Clients client) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    DocumentReference ref = await db.collection("clients").add({
      "cliente": client.cliente,
      "email": client.email,
      "telefone": client.telefone
    });
    final SnackBar snackBar = SnackBar(
        content: Text("Usuário cadastrado com sucesso"),
        duration: Duration(seconds: 5));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pushNamed('/main-page');
  } catch (e) {
    //print('Aconteceu o erro: ' + e.toString());
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao cadastrar cliente " + e.toString()),
        duration: Duration(seconds: 5));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void listClient() {}
