// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist/controller/user-controller.dart';
import 'package:tech_assist/main.dart';
import 'package:tech_assist/utils/appColors.dart';

class HomePage extends StatefulWidget {
  //const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String totFiles = '16 Fichas de atendimento';
  String openFiles = '3 em aberto';
  String totBudgets = '13 Orçamentos realizados';
  String openBudgets = '4 em andamento';
  String totClients = '';
  String titlePage = '';

  Future recuperarNomeEmpresa(String userId) async {
    print('disgramaaa  ' + userId.toString());
    if (userId != null) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot snapshot = await db
          .collection("users")
          .where('idUser', isEqualTo: userId) // Adicione a cláusula where aqui
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.size > 0) {
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;

          setState(() {
            titlePage = 'Olá, ' + data['nomeEmpresa'].toString().toUpperCase();
          });
          print('hellooooo ' + titlePage.toString());
          return querySnapshot.docs.first;
        } else {
          throw Exception(
              'Documento não encontrado'); // Lança uma exceção se nenhum documento for encontrado
        }
      });
    }
  }

  void quantidadeClientes(String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection('clients')
        .where('idUser', isEqualTo: userId) // Adicione a cláusula where aqui
        .where('status', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      int count = querySnapshot.size;
      print('Total de documentos: $count');

      setState(() {
        totClients = 'Total de clientes: $count';
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //titlePage = 'Não achei nada seu idiota';

    recuperarNomeEmpresa(userId.toString());
    quantidadeClientes(userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      titlePage,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: AppColors.titleColorBlack,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: 88,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: AppColors.secondColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Container(
                                width: 48,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.containerColorWhite,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Icon(
                                  Icons.description,
                                  size: 24,
                                  color: AppColors.secondColor,
                                )),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                totFiles,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  openFiles,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textColorGrey)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: 88,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: AppColors.containerColorBlack,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Container(
                                width: 48,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.containerColorWhite,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: Icon(
                                  Icons.assignment_turned_in_rounded,
                                  size: 24,
                                  color: AppColors.containerColorBlack,
                                )),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                totBudgets,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  openBudgets,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textColorGrey)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        height: 88,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: Colors.white,
                            border: Border.all(
                                width: 2, color: AppColors.secondColor)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Container(
                                  width: 48,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.secondColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Icon(
                                    Icons.badge_rounded,
                                    size: 24,
                                    color: Colors.white,
                                  )),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  totClients,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.textColorBlack)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
