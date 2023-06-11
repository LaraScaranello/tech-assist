// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unused_local_variable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tech_assist/controller/user-controller.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'package:lottie/lottie.dart';
import 'package:tech_assist/views/user/user-login.dart';

class MyAccountPage extends StatefulWidget {
  final String? usuario;

  const MyAccountPage({Key? key, this.usuario}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

// variáveis
String msgErro = '';
bool isButtonVisible = false;

// função para inativar uma conta de usuário
void removerUsuario(BuildContext context, String usuario) async {
  if (usuario.isEmpty) {
    msgErro = "Registro não encontrado";
  }

  if (msgErro.isEmpty) {
    confirmaExclusao(context, usuario);
    Navigator.pop(context);
    Navigator.of(context).pushNamed('/user-login');
  }
}

//exibir caixa de diálogo para confirmar a exclusão da conta do usuário
Future<void> confirmaExclusao(BuildContext context, String usuario) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tem certeza que deseja excluir a sua conta?",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontSize: 20,
                    color: AppColors.titleColorBlack,
                    fontWeight: FontWeight.w600),
              ),
              textAlign: TextAlign.center),
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
                          removerUsuario(context, usuario);
                        },
                        child: Text("Sim",
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
                        child: Text("Não",
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

class _MyAccountPageState extends State<MyAccountPage> {
  // controladores dos campos de texto
  var nomeEmpresaController = new TextEditingController();
  var nomeController = new TextEditingController();
  var telefoneController = new TextEditingController();

  // máscaras
  final maskTelefone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

  // validar campos para poder salvar a atualização do usuário
  void validarCampos() {
    if (nomeEmpresaController.text.isEmpty) {
      msgErro = 'Preencha o nome da empresa';
    } else if (nomeController.text.isEmpty) {
      msgErro = 'Preencha o nome do responsável';
    } else if (telefoneController.text.isEmpty) {
      msgErro = 'Preencha o telefone';
    }

    if (msgErro.isEmpty) {
      if (widget.usuario != null) {
        updateUser(
            context,
            widget.usuario.toString(),
            nomeEmpresaController.text,
            nomeController.text,
            telefoneController.text);
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

  // função para recuperar os dados do usuário logado e trazer as informações na tela
  void recuperarDados() async {
    if (widget.usuario != null) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot snapshot = await db
          .collection("users")
          .where('idUser', isEqualTo: widget.usuario)
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
          throw Exception('Documento não encontrado');
        }
      });
    }
  }

  // função para sair da conta
  void fazerLogout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => UserLoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  // iniciar o estado da tela da aplicação
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
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  lottieAnimation(),
                ],
              ),
              GestureDetector(
                child:
                    Icon(Icons.logout, color: AppColors.primaryColor, size: 40),
                onTap: fazerLogout,
              ),
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

                // área do botão salvar - atualizar as informações do usuário
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
                        validarCampos();
                      },
                    ),
                  ),
                ),

                // área para inativar a conta do usuário
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
                        "Excluir minha conta",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        setState(() {
                          confirmaExclusao(context, widget.usuario.toString());
                        });
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
