// ignore_for_file: unnecessary_new, file_names, unused_local_variable, prefer_const_constructors, sized_box_for_whitespace, unused_label, non_constant_identifier_names, avoid_types_as_parameter_names, must_call_super, annotate_overrides, prefer_interpolation_to_compose_strings, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tech_assist/Utils/appColors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tech_assist/model/users.dart';

class RegisterUserPage extends StatefulWidget {
  //const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

bool _passwordVisible = true;

class _RegisterUserPageState extends State<RegisterUserPage> {
  void initState() {
    _passwordVisible = true;
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
  void validaCampos() {
    // passo 1 - recuperar os dados
    String nomeEmpresa = nomeEmpresaController.text;
    String nome = nomeController.text;
    String telefone = telefoneController.text;
    String email = emailController.text;
    String senha = senhaController.text;
    String confirmaSenha = confirmaSenhaController.text;
    String msgErro = "";

    if (nomeEmpresa.isNotEmpty) {
      if (nome.isNotEmpty) {
        if (telefone.isNotEmpty) {
          if (email.isNotEmpty && email.contains("@")) {
            if (senha.isNotEmpty && senha.length > 6) {
              if (confirmaSenha == senha) {
                if (termos == false) {
                  msgErro = "Aceite os termos e condições";
                } else {
                  // passo 2 - cadastro no banco de dados
                  // 1: receber os dados da interface em um objeto model
                  Users user = new Users();

                  user.nomeEmpresa = nomeEmpresa;
                  user.nome = nome;
                  user.telefone = telefone;
                  user.email = email;
                  user.senha = senha;

                  // 2: executar o método cadastraUsuario(user)
                  cadastraUsuario(user);
                }
              } else {
                msgErro = "As senhas não combinam";
              }
            } else {
              msgErro = "Preencha a senha com mais de 6 caracteres";
            }
          } else {
            msgErro = "Preencha o e-mail";
          }
        } else {
          msgErro = "Preencha o telefone";
        }
      } else {
        msgErro = "Preencha o nome";
      }
    } else {
      msgErro = "Preencha o nome da empresa";
    }

    if (msgErro != "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.textColorRed,
        content: Text(msgErro),
      ));
    }
  }

  // Método que cadastra o usuário no firebase
  void cadastraUsuario(user) async {
    // instanciar o firebase (autenticação)
    FirebaseAuth auth = FirebaseAuth.instance;

    // criar o usuário com email e senha
    auth
        .createUserWithEmailAndPassword(email: user.email, password: user.senha)
        .then((firebaseUser) {
      final SnackBar snackBar = SnackBar(
          content: Text("Usuário cadastrado com sucesso"),
          duration: Duration(seconds: 5));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushNamed(context, 'login-page');
    }).catchError((erro) {
      print("Aconteceu o erro: " + erro.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      controller: confirmaSenhaController,
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
                    Text(
                      "Concordo com os termos e condições",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 14, color: AppColors.textColorBlack),
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
                        validaCampos();
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
