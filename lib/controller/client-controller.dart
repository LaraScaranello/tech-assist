// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tech_assist/model/clients.dart';
import 'package:tech_assist/utils/appColors.dart';

void newClient(BuildContext context, Clients client) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    await db.collection("clients").add({
      "idUser": client.idUser,
      "cliente": client.cliente,
      "email": client.email,
      "telefone": client.telefone,
      "status": client.status
    });
    final SnackBar snackBar = SnackBar(
        content: Text("Cliente cadastrado com sucesso"),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.secondColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //Navigator.of(context).pushNamed('/main-page');
  } catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao cadastrar cliente " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void updateClient(BuildContext context, String idClient, Clients client) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    await db.collection("clients").doc(idClient).update({
      "idUser": client.idUser,
      "cliente": client.cliente,
      "email": client.email,
      "telefone": client.telefone,
      "status": client.status
    });
  } catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao atualizar cliente " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void deleteClient(BuildContext context, String idClient) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    await db.collection("clients").doc(idClient).update({"status": false});
  } catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao inativar cliente " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
