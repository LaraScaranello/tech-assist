// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tech_assist/model/files.dart';
import 'package:tech_assist/utils/appColors.dart';

void newFile(BuildContext context, Files file) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    await db.collection("files").add({
      "idUser": file.idUser,
      "numFicha": file.numFicha,
      "status": file.status,
      "cliente": file.cliente,
      "email": file.email,
      "telefone": file.telefone,
      "dataAbertura": file.dataAbertura,
      "aparelho": file.aparelho,
      "defeito": file.defeito
    });
    final SnackBar snackBar = SnackBar(
      content: Text("Ficha de atendimento cadastrada com sucesso"),
      duration: Duration(seconds: 5),
      backgroundColor: AppColors.secondColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } catch (e) {
    final SnackBar snackBar = SnackBar(
      content: Text("Erro ao cadastrar a ficha de atendimento: $e"),
      duration: Duration(seconds: 5),
      backgroundColor: AppColors.textColorRed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Future<int> getNextId() async {
  try {
    final idCounterDoc =
        FirebaseFirestore.instance.collection('files').doc('numFicha');

    final idCounterSnapshot = await idCounterDoc.get();

    if (idCounterSnapshot.exists) {
      int currentId = idCounterSnapshot.data()!['current_id'];
      int nextId = currentId + 1;

      await idCounterDoc.update({'current_id': nextId});

      return nextId;
    } else {
      int nextId = 1;

      await idCounterDoc.set({'current_id': nextId});

      return nextId;
    }
  } catch (e) {
    return -1;
  }
}

void updateClient(BuildContext context, String idFicha, Files file) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    await db.collection("files").doc(idFicha).update({
      "idUser": file.idUser,
      "status": file.status,
      "cliente": file.cliente,
      "email": file.email,
      "telefone": file.telefone,
      "dataAbertura": file.dataAbertura,
      "aparelho": file.aparelho,
      "defeito": file.defeito,
    });
  } catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao atualizar cliente " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
