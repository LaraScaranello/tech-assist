// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, unused_local_variable, unnecessary_new, must_be_immutable, unused_element, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tech_assist/model/clients.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'package:tech_assist/controller/client-controller.dart';
import 'package:tech_assist/main.dart';

class CreateClient extends StatefulWidget {
  final String? cliente;

  const CreateClient({Key? key, this.cliente}) : super(key: key);

  @override
  State<CreateClient> createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  // controladores dos campos de texto
  var nomeController = TextEditingController();
  var documentoController = TextEditingController();
  var emailController = TextEditingController();
  var telefoneController = TextEditingController();

  // variáveis
  String titlePage = '';
  String msgErro = '';
  String? idClient = '';
  bool isButtonVisible = false;
  bool? isCheckedStatus = true;

  Future<void> validarCampos() async {
    if (nomeController.text.isEmpty) {
      msgErro = 'Preencha o nome';
    } else if (documentoController.text.isEmpty) {
      msgErro = 'Preencha o CPF';
    } else if (emailController.text.isEmpty) {
      msgErro = 'Preencha o e-mail';
    } else if (!emailController.text.contains('@')) {
      msgErro = 'Insira um e-mail válido';
    } else if (telefoneController.text.isEmpty) {
      msgErro = 'Preencha o telefone';
    }

    if (msgErro.isEmpty) {
      Clients client = new Clients(
          userId,
          nomeController.text,
          documentoController.text,
          emailController.text,
          telefoneController.text,
          isCheckedStatus!);

      bool cpfCadastrado = await verificaDocumento(client.documento);

      if (cpfCadastrado) {
        final snackBar = SnackBar(
          content: Text("O CPF informado já está cadastrado"),
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.textColorRed,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        if (widget.cliente != null) {
          updateClient(context, widget.cliente.toString(), client);
          Navigator.pop(context);
        } else {
          newClient(context, client);
          Navigator.pop(context);
        }
      }
    } else {
      final SnackBar snackBar = SnackBar(
        content: Text(msgErro),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      msgErro = '';
    }
  }

  void removerCliente() async {
    if (widget.cliente == null) {
      msgErro = "Registro não encontrado";
    }

    if (msgErro.isEmpty) {
      deleteClient(context, idClient.toString());
      Navigator.pop(context);
    }
  }

  void recuperarDados() async {
    if (widget.cliente != null) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await db.collection("clients").doc(widget.cliente).get();
      Map<String, dynamic> dados = snapshot.data() as Map<String, dynamic>;

      setState(() {
        idClient = widget.cliente!;
        nomeController.text = dados['cliente'].toString();
        documentoController.text = dados['documento'].toString();
        emailController.text = dados['email'].toString();
        telefoneController.text = dados['telefone'].toString();
        isCheckedStatus = dados['status'];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    nomeController.clear();
    documentoController.clear();
    emailController.clear();
    telefoneController.clear();

    if (widget.cliente != null) {
      recuperarDados();
      titlePage = "Editando Cliente";
      isButtonVisible = true;
    } else {
      titlePage = "Novo Cliente";
      isCheckedStatus = true;
      isButtonVisible = false;
    }
  }

  // máscaras
  final maskTelefone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});
  final maskDocumento = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      titlePage,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: AppColors.titleColorBlack,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
                // área do campo nome do cliente
                Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 8),
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

                // área do campo documento
                Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        size: 18,
                        Icons.person_pin_rounded,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "CPF",
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
                    inputFormatters: [maskDocumento],
                    controller: documentoController,
                    maxLength: 14,
                    decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),

                // área do campo e-mail
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

                // área do campo telefone
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
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.secondColor,
                          value: isCheckedStatus,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckedStatus = value!;
                            });
                          },
                        ),
                        const Text('Ativo'),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        width: 180,
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
                            validarCampos();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 8),
                      child: Container(
                        width: 180,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: AppColors.colorDegradeRed,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          child: Text(
                            "Cancelar",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
