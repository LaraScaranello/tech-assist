// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tech_assist/views/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // para garantir que a aplicação execute somente depois da conexão com o firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //FirebaseFirestore db = FirebaseFirestore.instance;

  //VAMOS VER SE ESSA CARAIA LISTA
  //QuerySnapshot querySnapshot = await db.collection("clients").get();
  //for (DocumentSnapshot item in querySnapshot.docs) {
  //  Map<String, dynamic> dados = item.data() as Map<String, dynamic>;
  //  print("Dados: " + dados.toString());
  //}

  // iniciar o app
  runApp(App());
}
