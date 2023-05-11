// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:tech_assist/views/budgets/create-budget.dart';
import 'package:tech_assist/views/budgets/edit-budget.dart';
import 'package:tech_assist/views/clients/create-client.dart';
import 'package:tech_assist/views/clients/edit-client.dart';
import 'package:tech_assist/views/files/edit-file.dart';
import 'package:tech_assist/views/main-page.dart';
import 'package:tech_assist/views/files/create-file.dart';
import 'package:tech_assist/views/user/user-login.dart';
import 'package:tech_assist/views/user/user-register.dart';

// classe criada para definir as rotas do app
class App extends StatelessWidget {
  //const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/user-login': (context) => UserLoginPage(),
        '/register-user': (context) => RegisterUserPage(),
        '/main-page': (context) => MainPage(),
        '/create-file': (context) => CreateFile(),
        '/edit-file': (context) => EditFile(),
        '/create-budget': (context) => CreateBudget(),
        '/edit-budget': (context) => EditBudget(),
        '/create-client': (context) => CreateClient(),
        '/edit-client': (context) => EditClient(),
      },
      initialRoute: '/user-login',
    );
  }
}
