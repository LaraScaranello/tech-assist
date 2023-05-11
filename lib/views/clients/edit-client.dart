// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tech_assist/utils/appColors.dart';

class EditClient extends StatefulWidget {
  //const OpenFile({super.key});

  @override
  State<EditClient> createState() => _EditClientState();
}

class _EditClientState extends State<EditClient> {
  // controladores dos campos de texto
  var nomeController = TextEditingController();
  var emailController = TextEditingController();
  var telefoneController = TextEditingController();

  // máscaras
  final maskTelefone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 70),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cliente",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: AppColors.titleColorBlack,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        size: 18,
                        Icons.person,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Nome do cliente",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 16, color: AppColors.textColorBlack),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        size: 18,
                        Icons.email,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "E-mail",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 16, color: AppColors.textColorBlack),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  color: AppColors.primaryOpacityColor,
                  child: TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack)),
                    controller: emailController,
                    maxLength: 30,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        size: 18,
                        Icons.phone,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Telefone",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 16, color: AppColors.textColorBlack),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  color: AppColors.primaryOpacityColor,
                  child: TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack)),
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
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 144,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                width: 1, color: AppColors.textColorBlue)),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Editar",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textColorBlue,
                                    fontWeight: FontWeight.w500),
                              )),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                        ),
                      ),
                      Container(
                        width: 144,
                        height: 48,
                        decoration: BoxDecoration(
                            gradient: AppColors.colorDegrade,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Ficha de atendimento",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                        ),
                      ),
                    ],
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
