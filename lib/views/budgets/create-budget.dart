// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, must_be_immutable, unused_element, unused_local_variable, unused_local_variable, unnecessary_new, annotate_overrides, avoid_print, file_names, duplicate_ignore, depend_on_referenced_packages, unused_import, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:tech_assist/controller/budget-controller.dart';
import 'package:tech_assist/main.dart';
import 'package:tech_assist/model/budgets.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'dart:io';
import 'package:flutter_full_pdf_viewer_null_safe/full_pdf_viewer_scaffold.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_extend/share_extend.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tech_assist/views/viewpdf.dart';

class CreateBudget extends StatefulWidget {
  String? ficha;
  String? orcamento;

  CreateBudget({Key? key, this.ficha, this.orcamento}) : super(key: key);

  @override
  State<CreateBudget> createState() => _CreateBudgetState();
}

class _CreateBudgetState extends State<CreateBudget> {
  // dropdown status
  final dropValueStatus = ValueNotifier('');
  final dropOptionsStatus = [
    'Em aprovação',
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
  var dataController = TextEditingController();

  // variáveis
  String titlePage = "Orçamento";
  String msgErro = '';
  String? orcamentoId = '';
  bool isButtonVisible = false;
  DateTime selectedDate = DateTime.now();
  int? idFicha;
  int? numFicha;
  String? empresa;

  // máscaras
  final maskTelefone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

  void recuperaNomeEmpresa(String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection('users')
        .where('idUser', isEqualTo: userId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      empresa = querySnapshot.docs[0].get('nomeEmpresa') as String;
    }
  }

  Future<void> generatePDF(
      BuildContext context, String empresa, Budgets budget) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('fonts/Roboto.ttf');
    final ttf = pw.Font.ttf(fontData);

    /*final image = pw.MemoryImage(
      File('assets/images/logo.png').readAsBytesSync(),
    );*/

    pdf.addPage(pw.MultiPage(
        build: (context) => [
              pw.Column(children: [
                pw.SizedBox(height: 4),
                /*pw.Container(
                  child: pw.Image(image),
                ),*/

                //Nome da Empresa
                pw.Center(
                    child: pw.Text(
                  empresa,
                  style: pw.TextStyle(
                    fontSize: 32,
                    fontWeight: pw.FontWeight.bold,
                  ),
                )),
                pw.SizedBox(height: 28),

                //Numero do Orçamento
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    children: [
                      pw.Text("Orçamento: ",
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(width: 16),
                      pw.Text(budget.numFicha.toString(),
                          style: pw.TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                //Data do orçamento
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    children: [
                      pw.Text("Data Abertura: ",
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(width: 16),
                      pw.Text(
                          DateFormat('dd/MM/yyyy').format(budget.dataAbertura),
                          style: pw.TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                //Nome do Cliente
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    children: [
                      pw.Text("Cliente: ",
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(width: 16),
                      pw.Text(budget.cliente.toString(),
                          style: pw.TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                //Email do Cliente
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    children: [
                      pw.Text("E-mail: ",
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(width: 16),
                      pw.Text(budget.email.toString(),
                          style: pw.TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                //Telefone do Cliente
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    children: [
                      pw.Text("Telefone: ",
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(width: 16),
                      pw.Text(budget.telefone.toString(),
                          style: pw.TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                //Aparelho
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    children: [
                      pw.Text("Aparelho: ",
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(width: 16),
                      pw.Text(budget.aparelho.toString(),
                          style: pw.TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                //Defeito
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text("Defeito: ",
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      )),
                ),
                pw.SizedBox(height: 4),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(budget.defeito.toString(),
                      style: pw.TextStyle(
                        fontSize: 20,
                      )),
                ),
                pw.SizedBox(height: 16),

                //Diagnostico
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text("Diagnóstico: ",
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      )),
                ),
                pw.SizedBox(height: 4),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(budget.diagnostico.toString(),
                      style: pw.TextStyle(
                        fontSize: 20,
                      )),
                ),
                pw.SizedBox(height: 16),

                //Serviços realizados
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text("Serviços Realizados: ",
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      )),
                ),
                pw.SizedBox(height: 4),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(budget.servicos.toString(),
                      style: pw.TextStyle(
                        fontSize: 20,
                      )),
                ),
                pw.SizedBox(height: 24),

                //Valor das peças
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    children: [
                      pw.Text("Valor Peças: ",
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(width: 16),
                      pw.Text(budget.valorPecas.toString(),
                          style: pw.TextStyle(fontSize: 32)),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                //Valor mão de obra
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    children: [
                      pw.Text("Valor Mão de Obra: ",
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(width: 16),
                      pw.Text(budget.valorMaoDeObra.toString(),
                          style: pw.TextStyle(
                            fontSize: 32,
                          )),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),
                //Valor total
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Row(
                    children: [
                      pw.Text("Valor Total: ",
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          )),
                      pw.SizedBox(width: 16),
                      pw.Text(budget.valorTotal.toString(),
                          style: pw.TextStyle(
                            fontSize: 32,
                          )),
                    ],
                  ),
                ),

                pw.SizedBox(height: 16),
                /*pw.Table.fromTextArray(data: <List<String>>[
                  <String>[
                    'Cliente',
                    'Aparelho',
                    'Defeito',
                    'Serviço',
                    'Valor Peças',
                    'Valor Mão de Obra',
                    'Valor Total'
                  ],
                  [
                    nome,
                    aparelho,
                    defeito,
                    servicos,
                    valorPecas.toString(),
                    valorMaoObra.toString(),
                    valorTotal.toString()
                  ],
                ])*/
              ])
            ]));
    final output = await getTemporaryDirectory();
    final String path = '${output.path}/orcamento.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerScreen(pdfPath: path),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dataController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);
      });
    }
  }

  void recuperarDados() async {
    if (widget.orcamento != null) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await db.collection("budgets").doc(widget.orcamento).get();
      Map<String, dynamic> dados = snapshot.data() as Map<String, dynamic>;
      setState(() {
        dropValueStatus.value = dados['status'];
        nomeController.text = dados['cliente'].toString();
        emailController.text = dados['email'].toString();
        telefoneController.text = dados['telefone'].toString();
        aparelhoController.text = dados['aparelho'].toString();
        defeitoController.text = dados['defeito'].toString();
        diagnosticoController.text = dados['diagnostico'].toString();
        servicosController.text = dados['servicos'].toString();
        dataController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);
        valorPecasController.text = dados['valorPecas'].toString();
        valorMaoObraController.text = dados['valorMaoDeObra'].toString();
        valorTotalController.text = dados['valorTotal'].toString();

        idFicha = dados['numFicha'];
        titlePage = "Orçamento nº $idFicha";
      });
    }
  }

  void carregaFicha() async {
    if (widget.ficha != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FirebaseFirestore db = FirebaseFirestore.instance;
        DocumentSnapshot snapshot =
            await db.collection("files").doc(widget.ficha).get();
        if (snapshot.exists) {
          Map<String, dynamic> dados = snapshot.data() as Map<String, dynamic>;
          if (mounted) {
            setState(() {
              nomeController.text = dados['cliente'].toString();
              emailController.text = dados['email'].toString();
              telefoneController.text = dados['telefone'].toString();
              aparelhoController.text = dados['aparelho'].toString();
              defeitoController.text = dados['defeito'].toString();
              idFicha = dados['numFicha'];
              titlePage = "Orçamento da ficha nº $idFicha";
            });
          }
        } else {
          FirebaseFirestore db = FirebaseFirestore.instance;
          DocumentSnapshot snapshot =
              await db.collection("budgets").doc(widget.ficha).get();
          Map<String, dynamic> dados = snapshot.data() as Map<String, dynamic>;
          setState(() {
            dropValueStatus.value = dados['status'];
            nomeController.text = dados['cliente'].toString();
            emailController.text = dados['email'].toString();
            telefoneController.text = dados['telefone'].toString();
            aparelhoController.text = dados['aparelho'].toString();
            defeitoController.text = dados['defeito'].toString();
            diagnosticoController.text = dados['diagnostico'].toString();
            servicosController.text = dados['servicos'].toString();
            dataController.text =
                DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);
            valorPecasController.text = dados['valorPecas'].toString();
            valorMaoObraController.text = dados['valorMaoDeObra'].toString();
            valorTotalController.text = dados['valorTotal'].toString();
            idFicha = dados['numFicha'];
            titlePage = "Orçamento nº $idFicha";
          });
        }
      });
    }
  }

  void atualizarValorTotal() {
    double valorPecas = double.tryParse(valorPecasController.text) ?? 0.0;
    double valorMaoObra = double.tryParse(valorMaoObraController.text) ?? 0.0;

    double valorTotal = valorPecas + valorMaoObra;
    valorTotalController.text = valorTotal.toString();
  }

  Future<void> validarCampos() async {
    if (dropValueStatus.value.isEmpty) {
      msgErro = 'Selecione o status do orçamento';
    } else if (nomeController.text.isEmpty) {
      msgErro = 'Preencha o campo nome do cliente';
    } else if (emailController.text.isEmpty) {
      msgErro = 'Preencha o campo e-mail';
    } else if (telefoneController.text.isEmpty) {
      msgErro = 'Preencha o campo telefone';
    } else if (aparelhoController.text.isEmpty) {
      msgErro = 'Preencha o campo aparelho';
    } else if (defeitoController.text.isEmpty) {
      msgErro = 'Preencha o campo defeito';
    } else if (diagnosticoController.text.isEmpty) {
      msgErro = 'Preencha o campo diagnóstico';
    } else if (servicosController.text.isEmpty) {
      msgErro = 'Preencha o campo serviços realizados';
    } else if (dataController.text.isEmpty) {
      msgErro = 'Selecione a data de abertura do orçamento';
    } else if (valorPecasController.text.isEmpty) {
      msgErro = 'Preencha o valor das peças';
    } else if (valorMaoObraController.text.isEmpty) {
      msgErro = 'Preencha o valor da mão de obra';
    } else if (valorTotalController.text.isEmpty) {
      msgErro = 'Preencha o valor total do orçamento';
    }
    if (msgErro.isEmpty) {
      Budgets budget = new Budgets(
          userId,
          idFicha,
          dropValueStatus.value.toString(),
          nomeController.text,
          emailController.text,
          telefoneController.text,
          DateTime.parse(dataController.text),
          aparelhoController.text,
          defeitoController.text,
          diagnosticoController.text,
          servicosController.text,
          double.parse(valorPecasController.text),
          double.parse(valorMaoObraController.text),
          double.parse(valorTotalController.text));

      if ((widget.ficha != null) && (widget.orcamento == null)) {
        newBudget(context, budget);
        Navigator.of(context).pushNamed('/main-page');
      } else if (widget.orcamento != null) {
        updateBudget(context, widget.orcamento.toString(), budget);

        Navigator.of(context).pushNamed('/main-page');
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

  void initState() {
    super.initState();

    setState(() {
      recuperaNomeEmpresa(userId.toString());

      if ((widget.ficha != null) && (widget.orcamento == null)) {
        carregaFicha();
        dropValueStatus.value = dropOptionsStatus[0];
      } else if ((widget.ficha == null) && (widget.orcamento != null)) {
        recuperarDados();
        isButtonVisible = true;
      } else {
        isButtonVisible = false;
      }
      valorPecasController.addListener(() {
        atualizarValorTotal();
      });

      valorMaoObraController.addListener(() {
        atualizarValorTotal();
      });
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
                      titlePage,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: AppColors.secondColor,
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
                                          fontSize: 16,
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
                        Icons.person,
                        size: 18,
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
                        Icons.email,
                        size: 18,
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
                        Icons.phone,
                        size: 18,
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
                        Icons.build,
                        size: 18,
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
                        Icons.assignment_late,
                        size: 18,
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
                        Icons.assignment_late,
                        size: 18,
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
                        Icons.assignment,
                        size: 18,
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
                        Icons.calendar_month,
                        size: 18,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Data de abertura",
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
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    controller: dataController,
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
                        Icons.price_change,
                        size: 18,
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
                        Icons.price_change,
                        size: 18,
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
                        Icons.price_check,
                        size: 18,
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
                    readOnly: true,
                    maxLength: 10,
                    decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
                Visibility(
                  visible: isButtonVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              width: 1, color: AppColors.textColorBlue)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        child: Text(
                          "Gerar PDF",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondColor),
                        ),
                        onPressed: () {
                          Budgets budget = new Budgets(
                              userId,
                              idFicha,
                              dropValueStatus.value.toString(),
                              nomeController.text,
                              emailController.text,
                              telefoneController.text,
                              DateTime.parse(dataController.text),
                              aparelhoController.text,
                              defeitoController.text,
                              diagnosticoController.text,
                              servicosController.text,
                              double.parse(valorPecasController.text),
                              double.parse(valorMaoObraController.text),
                              double.parse(valorTotalController.text));

                          generatePDF(context, empresa.toString(), budget);
                          /*
                          _createPdf(
                              context,
                              empresa.toString(),
                              idFicha!,
                              nomeController.text,
                              aparelhoController.text,
                              defeitoController.text,
                              servicosController.text,
                              double.parse(valorPecasController.text),
                              double.parse(valorMaoObraController.text),
                              double.parse(valorTotalController.text));*/
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
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
                      padding: const EdgeInsets.only(top: 8, left: 8),
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
