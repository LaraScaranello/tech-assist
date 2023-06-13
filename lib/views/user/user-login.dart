// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace, avoid_print, sort_child_properties_last, unused_local_variable, must_call_super, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist/Utils/appColors.dart';
import 'package:tech_assist/controller/user-controller.dart';
import 'package:tech_assist/main.dart';
import 'package:tech_assist/model/users.dart';
import 'package:tech_assist/views/main-page.dart';

class UserLoginPage extends StatefulWidget {
  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

//exibir caixa de diálogo para recurar a senha
var emailRecuperarSenhaController = TextEditingController();
Future<void> exibirRedefinirSenha(BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Esqueci minha senha",
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
                "Para redefinir sua senha, informe seu e-mail que lhe enviaremos um link com as instruções.",
                style: GoogleFonts.montserrat(
                  textStyle:
                      TextStyle(fontSize: 16, color: AppColors.textColorBlack),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  color: AppColors.primaryOpacityColor,
                  child: TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack)),
                    controller: emailRecuperarSenhaController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4)),
                      contentPadding: EdgeInsets.all(5),
                      hintStyle: TextStyle(color: AppColors.primaryColor),
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                          gradient: AppColors.colorDegrade,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: ElevatedButton(
                        onPressed: () {
                          resetPassword(
                              context, emailRecuperarSenhaController.text);
                        },
                        child: Text("Enviar",
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
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              width: 1, color: AppColors.textColorBlue)),
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
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                      ),
                    ),
                  ]),
            ),
          ],
        );
      });
}

class _UserLoginPageState extends State<UserLoginPage> {
  bool _passwordVisible = true;

  // controladores dos campos de texto
  var emailController = TextEditingController();
  var senhaController = TextEditingController();

  // método para efetuar o login no firebase

  void loginApp() async {
    Users user = new Users.Login(emailController.text, senhaController.text);
    efetuaLogin(context, user);
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _passwordVisible = true;

      emailController.clear();
      senhaController.clear();
    });
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
            child: Column(children: [
              lottieAnimation(),
              SizedBox(
                height: 5,
              ),

              // área do email
              Row(
                children: [
                  Icon(Icons.email, color: AppColors.primaryColor),
                  SizedBox(
                    width: 10,
                  ),
                  Text("E-mail",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack),
                      ),
                      textAlign: TextAlign.start),
                ],
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4)),
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),

              // área da senha
              Padding(
                padding: const EdgeInsets.only(top: 32),
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4)),
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),

              // área de recuperar senha
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  GestureDetector(
                    onTap: () {
                      exibirRedefinirSenha(context);
                    },
                    child: Text("Esqueci minha senha",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xff5A5A5A),
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ]),
              ),
              SizedBox(
                height: 30,
              ),

              // área do botão de login
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                    gradient: AppColors.colorDegrade,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    loginApp();
                  },
                ),
              ),

              // área para cadastrar um usuário
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Não tem uma conta?",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 14, color: AppColors.textColorBlack),
                      )),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/register-user');
                    },
                    child: Text("Cadastre-se",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget lottieAnimation() {
  return Container(
    margin: EdgeInsets.only(top: 1, bottom: 3),
    child: Lottie.asset('assets/animations/login.json',
        width: 200, height: 200, fit: BoxFit.fill),
  );
}
