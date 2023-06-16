// ignore_for_file: unnecessary_new, file_names, unused_local_variable, prefer_const_constructors, sized_box_for_whitespace, unused_label, non_constant_identifier_names, avoid_types_as_parameter_names, must_call_super, annotate_overrides, prefer_interpolation_to_compose_strings, avoid_print, use_key_in_widget_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tech_assist/Utils/appColors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tech_assist/controller/user-controller.dart';
import 'package:tech_assist/model/users.dart';

class RegisterUserPage extends StatefulWidget {
  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

Future<void> termosDeUso(BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Termos de Uso e Condições",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontSize: 20,
                    color: AppColors.titleColorBlack,
                    fontWeight: FontWeight.w600),
              ),
              textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(children: [
              Text(
                "Bem-vindo à Tech Assist! Este documento estabelece os termos e condições para o uso dos serviços de manutenção em informática oferecidos por nossa empresa fictícia. Ao utilizar nossos serviços, você concorda em cumprir as disposições estabelecidas neste Termo de Uso. Recomendamos que leia atentamente todas as informações apresentadas abaixo.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 16, color: AppColors.textColorBlack),
                ),
              ),
              Text(
                "1. Aceitação dos Termos de Uso. Ao acessar ou utilizar os serviços da Tech Assist, você reconhece e concorda que leu, compreendeu e aceitou os termos e condições aqui estabelecidos. Caso não concorde com esses termos, solicitamos que não utilize nossos serviços.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 16, color: AppColors.textColorBlack),
                ),
              ),
              Text(
                "2. Descrição dos Serviços. A Tech Assist oferece serviços de manutenção em informática, incluindo diagnóstico, reparo, atualização e suporte técnico para computadores, laptops, dispositivos móveis e outros equipamentos relacionados.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 16, color: AppColors.textColorBlack),
                ),
              ),
              Text(
                "3. Responsabilidades do Cliente. Ao solicitar nossos serviços, você declara que é o proprietário legal dos equipamentos para os quais está buscando assistência ou que possui a devida autorização do proprietário para solicitar os serviços em seu nome. Você é responsável por fornecer informações precisas e completas sobre os problemas enfrentados, bem como sobre quaisquer modificações realizadas anteriormente nos equipamentos.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 16, color: AppColors.textColorBlack),
                ),
              ),
              Text(
                "4. Lei Aplicável e Jurisdição. Estes Termos de Uso são regidos pelas leis do país fictício em que a Tech Assist está sediada. Quaisquer disputas decorrent",
                textAlign: TextAlign.justify,
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 16, color: AppColors.textColorBlack),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border:
                        Border.all(width: 1, color: AppColors.textColorBlue)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Voltar",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: AppColors.textColorBlue,
                            fontWeight: FontWeight.w500),
                      )),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ),
              ),
            ]),
          ),
        );
      });
}

bool _passwordVisible = true;
bool _passwordConfirmVisible = true;

class _RegisterUserPageState extends State<RegisterUserPage> {
  @override
  void initState() {
    super.initState();

    setState(() {
      _passwordVisible = true;
      _passwordConfirmVisible = true;

      nomeEmpresaController.clear();
      nomeController.clear();
      telefoneController.clear();
      emailController.clear();
      senhaController.clear();
      confirmaSenhaController.clear();
    });
  }

  // controladores dos campos de texto
  var nomeEmpresaController = new TextEditingController();
  var nomeController = new TextEditingController();
  var telefoneController = new TextEditingController();
  var emailController = new TextEditingController();
  var senhaController = new TextEditingController();
  var confirmaSenhaController = new TextEditingController();

  // máscaras
  final maskTelefone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

  // chechbok termos e condições
  bool termos = false;

  // chave do form
  final _formKey = GlobalKey<FormState>();

  // método que valida os campos
  void validarCampos() {
    String msgErro = "";

    if (nomeEmpresaController.text.isEmpty) {
      msgErro = "Preencha o nome da empresa";
    } else if (nomeController.text.isEmpty) {
      msgErro = "Preencha o nome do responsável";
    } else if (telefoneController.text.isEmpty) {
      msgErro = "Preencha o telefone";
    } else if (emailController.text.isEmpty) {
      msgErro = "Preencha o e-mail";
    } else if (!emailController.text.contains('@')) {
      msgErro = "Digite um e-mail válido";
    } else if (senhaController.text.isEmpty) {
      msgErro = "Preencha a senha";
    } else if (senhaController.text.length < 6) {
      msgErro = "Preencha a senha com 6 ou mais caracteres";
    } else if (confirmaSenhaController.text.isEmpty) {
      msgErro = "Por favor, confirme a senha";
    } else if (senhaController.text != confirmaSenhaController.text) {
      msgErro = "As senhas não combinam";
    } else if (termos == false) {
      msgErro = "Aceite os termos e condições";
    }

    if (msgErro.isEmpty) {
      Users user = new Users(nomeEmpresaController.text, nomeController.text,
          telefoneController.text, emailController.text, senhaController.text);
      newUser(context, user);
    } else {
      final SnackBar snackBar = SnackBar(
        content: Text(msgErro),
        duration: Duration(seconds: 5),
        backgroundColor: AppColors.textColorRed,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: double.infinity,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                lottieAnimation(),
                Text("Cadastro",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: AppColors.titleColorBlack,
                          fontWeight: FontWeight.w600),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text("Crie sua conta agora mesmo",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.textColorBlack,
                        ),
                      )),
                ),

                // área do campo nome da empresa
                Padding(
                  padding: const EdgeInsets.only(top: 40),
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

                // área do campo email
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.email, color: AppColors.primaryColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Email",
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
                ),

                // área do campo senha
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.lock, color: AppColors.primaryColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Senha",
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
                      controller: senhaController,
                      maxLength: 15,
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.textColorBlack,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          counterText: "",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),

                // área do campo confirmar senha
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.lock, color: AppColors.primaryColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Confirme a senha",
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
                      controller: confirmaSenhaController,
                      maxLength: 15,
                      obscureText: _passwordConfirmVisible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordConfirmVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.textColorBlack,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordConfirmVisible =
                                    !_passwordConfirmVisible;
                              });
                            },
                          ),
                          counterText: "",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),

                // área dos termos de uso
                Row(
                  children: [
                    Checkbox(
                        value: termos,
                        activeColor: AppColors.primaryColor,
                        onChanged: (bool? valor) {
                          setState(() {
                            termos = valor!;
                          });
                        }),
                    GestureDetector(
                      onTap: () {
                        termosDeUso(context);
                      },
                      child: Text(
                        "Concordo com os termos e condições",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 14, color: AppColors.textColorBlack),
                        ),
                      ),
                    )
                  ],
                ),

                // área do botão de login
                Padding(
                  padding: const EdgeInsets.only(top: 16),
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
                        "Cadastrar",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        validarCampos();
                      },
                    ),
                  ),
                ),
              ]),
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
    child: Lottie.asset('assets/animations/user-register.json',
        width: 200, height: 200, fit: BoxFit.fill),
  );
}
