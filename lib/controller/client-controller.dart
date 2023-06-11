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
      "documento": client.documento,
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
      "documento": client.documento,
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

Future<bool> verificaDocumento(String documento) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('clients')
        .where('documento', isEqualTo: documento)
        .limit(1)
        .get();
    return querySnapshot.size > 0;
  } catch (e) {
    return false;
  }
}
