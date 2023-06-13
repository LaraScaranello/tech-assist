// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tech_assist/model/budgets.dart';
import 'package:tech_assist/utils/appColors.dart';

void newBudget(BuildContext context, Budgets budget) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  try {
    await db.collection("budgets").add({
      "idUser": budget.idUser,
      "numFicha": budget.numFicha,
      "status": budget.status,
      "cliente": budget.cliente,
      "email": budget.email,
      "telefone": budget.telefone,
      "dataAbertura": budget.dataAbertura,
      "aparelho": budget.aparelho,
      "defeito": budget.defeito,
      "diagnostico": budget.diagnostico,
      "servicos": budget.servicos,
      "valorPecas": budget.valorPecas,
      "valorMaoDeObra": budget.valorMaoDeObra,
      "valorTotal": budget.valorTotal
    });
    final SnackBar snackBar = SnackBar(
      content: Text("Orçamento cadastrado com sucesso"),
      duration: Duration(seconds: 5),
      backgroundColor: AppColors.secondColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } catch (e) {
    final SnackBar snackBar = SnackBar(
      content: Text("Erro ao cadastrar o orçamento: $e"),
      duration: Duration(seconds: 5),
      backgroundColor: AppColors.textColorRed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void updateBudget(
    BuildContext context, String idOrcamento, Budgets budget) async {
  FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    await db.collection("budgets").doc(idOrcamento).update({
      "idUser": budget.idUser,
      "numFicha": budget.numFicha,
      "status": budget.status,
      "cliente": budget.cliente,
      "email": budget.email,
      "telefone": budget.telefone,
      "dataAbertura": budget.dataAbertura,
      "aparelho": budget.aparelho,
      "defeito": budget.defeito,
      "diagnostico": budget.diagnostico,
      "servicos": budget.servicos,
      "valorPecas": budget.valorPecas,
      "valorMaoDeObra": budget.valorMaoDeObra,
      "valorTotal": budget.valorTotal
    });
  } catch (e) {
    final SnackBar snackBar = SnackBar(
        content: Text("Erro ao atualizar cliente " + e.toString()),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
