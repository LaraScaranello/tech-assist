// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tech_assist/utils/appColors.dart';

class CreateBudget extends StatefulWidget {
  String? ficha;

  CreateBudget({Key? key, this.ficha}) : super(key: key);

  @override
  State<CreateBudget> createState() => _CreateBudgetState();
}

class _CreateBudgetState extends State<CreateBudget> {
  // dropdown status
  final dropValueStatus = ValueNotifier('');
  final dropOptionsStatus = [
    'Aguardando aprovação',
    'Em andamento',
    'Finalizado',
    'Cancelado'
  ];

  // controladores dos campos de texto
  var nomeController = TextEditingController();
  var emailController = TextEditingController();
  var telefoneController = TextEditingController();
  var aparelhoController = TextEditingController();
  var defeitoController = TextEditingController();
  var diagnosticoController = TextEditingController();
  var servicosController = TextEditingController();
  var valorPecasController = TextEditingController();
  var valorMaoObraController = TextEditingController();
  var valorTotalController = TextEditingController();

  // máscaras
  final maskTelefone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

  void carregaFicha() async {
    if (widget.ficha != null) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await db.collection("files").doc(widget.ficha).get();
      Map<String, dynamic> dados = snapshot.data() as Map<String, dynamic>;

      print(dados['numFicha']);
      setState(() {
        dropValueStatus.value = dados['status'].toString();
        nomeController.text = dados['cliente'].toString();
        emailController.text = dados['email'].toString();
        telefoneController.text = dados['telefone'].toString();
        aparelhoController.text = dados['aparelho'].toString();
        defeitoController.text = dados['defeito'].toString();
      });
    }
  }

  void initState() {
    super.initState();

    setState(() {
      if (widget.ficha != null) {
        // chamar função que carrega os dados da ficha no orçamento
        carregaFicha();
      } else {}
    });
  }

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
                      "Orçamento",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: AppColors.titleColorBlack,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      Icon(
                        Icons.assignment_returned,
                        size: 18,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Status",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 16, color: AppColors.textColorBlack),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ValueListenableBuilder(
                        valueListenable: dropValueStatus,
                        builder: (BuildContext context, String value, _) {
                          return DropdownButtonFormField<String>(
                            dropdownColor: AppColors.primaryOpacityColor,
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            hint: Text(
                              dropOptionsStatus[0],
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                              ),
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              contentPadding: EdgeInsets.all(8),
                              alignLabelWithHint: true,
                            ),
                            value: (value.isEmpty) ? null : value,
                            onChanged: (escolha) =>
                                dropValueStatus.value = escolha.toString(),
                            items: dropOptionsStatus
                                .map(
                                  (op) => DropdownMenuItem(
                                    value: op,
                                    child: Text(
                                      op,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: AppColors.textColorBlack),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        }),
                  ),
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
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        size: 18,
                        Icons.build,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Aparelho",
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
                    controller: aparelhoController,
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
                        Icons.assignment_late,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Defeito",
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
                  height: 80,
                  color: AppColors.primaryOpacityColor,
                  child: TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack)),
                    controller: defeitoController,
                    maxLines: 5,
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
                        Icons.assignment_late,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Diagnóstico",
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
                  height: 80,
                  color: AppColors.primaryOpacityColor,
                  child: TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack)),
                    controller: diagnosticoController,
                    maxLines: 5,
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
                        Icons.assignment,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Serviços realizados",
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
                  height: 80,
                  color: AppColors.primaryOpacityColor,
                  child: TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack)),
                    controller: servicosController,
                    maxLines: 5,
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
                        Icons.price_change,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Valor das peças",
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
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack)),
                    controller: valorPecasController,
                    maxLength: 10,
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
                        Icons.price_change,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Valor da mão de obra",
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
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack)),
                    controller: valorMaoObraController,
                    maxLength: 10,
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
                        Icons.price_check,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Valor total",
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
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 16, color: AppColors.textColorBlack)),
                    controller: valorTotalController,
                    maxLength: 10,
                    decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
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
