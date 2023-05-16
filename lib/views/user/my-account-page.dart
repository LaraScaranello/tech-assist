// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'package:lottie/lottie.dart';

class MyAccountPage extends StatefulWidget {
  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  // controladores dos campos de texto
  var nomeEmpresaController = new TextEditingController();
  var nomeController = new TextEditingController();
  var telefoneController = new TextEditingController();

  // máscaras
  final maskTelefone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: double.infinity,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                lottieAnimation(),
                Text("Conta",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: AppColors.titleColorBlack,
                          fontWeight: FontWeight.w600),
                    )),
                // área do campo nome da empresa
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Icon(Icons.add_business, color: AppColors.primaryColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Nome da Empresa",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 16, color: AppColors.textColorBlack),
                          ),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: AppColors.primaryOpacityColor,
                    child: TextField(
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 16, color: AppColors.textColorBlack)),
                      controller: nomeEmpresaController,
                      maxLength: 70,
                      decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),

                // área do campo nome
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: AppColors.primaryColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Nome do Responsável",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 16, color: AppColors.textColorBlack),
                          ),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: AppColors.primaryOpacityColor,
                    child: TextField(
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 16, color: AppColors.textColorBlack)),
                      controller: nomeController,
                      maxLength: 70,
                      decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),

                // área do campo telefone
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.phone, color: AppColors.primaryColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Telefone",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 16, color: AppColors.textColorBlack),
                          ),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: AppColors.primaryOpacityColor,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [maskTelefone],
                      controller: telefoneController,
                      maxLength: 14,
                      decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                        gradient: AppColors.colorDegrade,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget lottieAnimation() {
  return Container(
    margin: EdgeInsets.only(top: 1, bottom: 3),
    child: Lottie.asset('assets/animations/user-icon.json',
        width: 80, height: 80, fit: BoxFit.fill),
  );
}
