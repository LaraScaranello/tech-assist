// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tech_assist/controller/user-controller.dart';
import 'package:tech_assist/model/users.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'package:lottie/lottie.dart';

class MyAccountPage extends StatefulWidget {
  final String? usuario;

  const MyAccountPage({Key? key, this.usuario}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  // controladores dos campos de texto
  var nomeEmpresaController = new TextEditingController();
  var nomeController = new TextEditingController();
  var telefoneController = new TextEditingController();

  // variáveis
  String msgErro = '';
  bool isButtonVisible = false;

  // máscaras
  final maskTelefone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

  void validarCampos() {
    if (nomeEmpresaController.text.isEmpty) {
      msgErro = 'Preencha o nome da empresa';
    } else if (nomeController.text.isEmpty) {
      msgErro = 'Preencha o nome do responsável';
    } else if (telefoneController.text.isEmpty) {
      msgErro = 'Preencha o telefone';
    }
  }

  void removerUsuario() async {
    if (widget.usuario == null) {
      msgErro = "Registro não encontrado";
    }

    if (msgErro.isEmpty) {
      deleteUser(context, widget.usuario.toString());
      Navigator.pop(context);
    }
  }

  void recuperarDados() async {
    if (widget.usuario != null) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot snapshot = await db
          .collection("users")
          .where('idUser',
              isEqualTo: widget.usuario) // Adicione a cláusula where aqui
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.size > 0) {
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;

          setState(() {
            nomeEmpresaController.text = data['nomeEmpresa'].toString();
            nomeController.text = data['nome'].toString();
            telefoneController.text = data['telefone'].toString();
          });
          return querySnapshot.docs.first;
        } else {
          throw Exception(
              'Documento não encontrado'); // Lança uma exceção se nenhum documento for encontrado
        }
      });
    }
  }

  void fazerLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.usuario != null) {
        recuperarDados();
        isButtonVisible = true;
      } else {
        isButtonVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Container(
          margin: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              lottieAnimation(),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                      onPressed: () {
                        //updateUser();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                        gradient: AppColors.colorDegradeRed,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      child: Text(
                        "Sair da Conta",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        fazerLogout();
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
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
