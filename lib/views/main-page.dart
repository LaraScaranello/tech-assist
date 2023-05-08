// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'package:tech_assist/views/budgets-page.dart';
import 'package:tech_assist/views/clients-page.dart';
import 'package:tech_assist/views/files-page.dart';
import 'package:tech_assist/views/home-page.dart';
import 'package:tech_assist/views/my-account-page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // lsta de páginas para o bottomNavigatorBar
  List pages = [
    HomePage(),
    FilesPage(),
    BudgetsPage(),
    ClientsPage(),
    MyAccountPage(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.bottomBar,
        unselectedItemColor: AppColors.bottomBar.withOpacity(0.7),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
              icon: Icon(Icons.description), label: 'Fichas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check), label: 'Orçamentos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_search), label: 'Clientes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Conta'),
        ],
      ),
    );
  }
}
