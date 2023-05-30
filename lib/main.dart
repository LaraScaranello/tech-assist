// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:tech_assist/views/app.dart';
import 'package:firebase_core/firebase_core.dart';

String? userId = '';
String? nomeEmpresa = '';

void main() async {
  // para garantir que a aplicação execute somente depois da conexão com o firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // iniciar o app
  runApp(App());
}
