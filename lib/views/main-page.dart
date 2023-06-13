// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist/main.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'package:tech_assist/views/clients/clients-page.dart';
import 'package:tech_assist/views/budgets/budgets-page.dart';
import 'package:tech_assist/views/files/files-page.dart';
import 'package:tech_assist/views/home-page.dart';
import 'package:tech_assist/views/user/my-account-page.dart';

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
    MyAccountPage(usuario: userId),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
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
        selectedItemColor: AppColors.secondColor,
        unselectedItemColor: AppColors.secondColor.withOpacity(0.5),
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
              icon: Icon(Icons.assignment_turned_in_rounded),
              label: 'Orçamentos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.badge_rounded), label: 'Clientes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Conta'),
        ],
      ),
    );
  }
}
