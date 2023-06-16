// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, avoid_function_literals_in_foreach_calls, unused_element, unused_local_variable, unnecessary_new, use_build_context_synchronously, annotate_overrides, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tech_assist/controller/files-controller.dart';
import 'package:tech_assist/main.dart';
import 'package:tech_assist/model/files.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:tech_assist/views/budgets/create-budget.dart';

class CreateFile extends StatefulWidget {
  final String? ficha;

  const CreateFile({Key? key, this.ficha}) : super(key: key);

  @override
  State<CreateFile> createState() => _CreateFileState();
}

class _CreateFileState extends State<CreateFile> {
  // dropdown status
  final dropValueStatus = ValueNotifier('');
  final dropOptionsStatus = [
    'Em aberto',
    'Orçamento',
    'Em execução',
    'Fechado',
    'Cancelado'
  ];

  // controladores dos campos de texto
  var nomeController = TextEditingController();
  var emailController = TextEditingController();
  var telefoneController = TextEditingController();
  var aparelhoController = TextEditingController();
  var defeitoController = TextEditingController();
  var dataController = TextEditingController();

  //variaveis
  String titlePage = "Ficha de atendimento";
  String msgErro = '';
  String? fichaId = '';
  bool isButtonVisible = false;
  DateTime selectedDate = DateTime.now();
  int? idFicha;
  int? nextId;

  // máscaras
  final maskTelefone = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

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

  Future<void> validarCampos() async {
    if (dropValueStatus == null) {
      msgErro = 'Selecione o status da ficha';
    } else if (nomeController.text.isEmpty) {
      msgErro = 'Preencha o campo nome do cliente';
    } else if (emailController.text.isEmpty) {
      msgErro = 'Preencha o campo e-mail';
    } else if (telefoneController.text.isEmpty) {
      msgErro = 'Preencha o campo telefone';
    } else if (dataController.text.isEmpty) {
      msgErro = 'Selecione a data de abertura da ficha';
    } else if (aparelhoController.text.isEmpty) {
      msgErro = 'Preencha o campo aparelho';
    } else if (defeitoController.text.isEmpty) {
      msgErro = 'Preencha o campo defeito';
    }
    if (msgErro.isEmpty) {
      if (nextId != null) {
        idFicha = nextId;
      } else {
        final SnackBar snackBar = SnackBar(
          content: Text("Erro ao recuperar ID"),
          duration: Duration(seconds: 5),
          backgroundColor: AppColors.secondColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      Files file = new Files(
          userId,
          idFicha,
          dropValueStatus.value.toString(),
          nomeController.text,
          emailController.text,
          telefoneController.text,
          DateTime.parse(dataController.text),
          aparelhoController.text,
          defeitoController.text);

      if (widget.ficha != null) {
        updateFile(context, widget.ficha.toString(), file);
        Navigator.pop(context);
      } else {
        newFile(context, file);
        Navigator.pop(context);
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

  Future<void> proximoIdFicha() async {
    nextId = await getNextId();
    setState(() {
      titlePage = "Ficha de Atendimento nº $nextId";
    });
  }

  void recuperarDados() async {
    if (widget.ficha != null) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await db.collection("files").doc(widget.ficha).get();
      Map<String, dynamic> dados = snapshot.data() as Map<String, dynamic>;
      setState(() {
        fichaId = widget.ficha!;
        nextId = dados['numFicha'];
        dropValueStatus.value = dados['status'].toString();
        nomeController.text = dados['cliente'].toString();
        emailController.text = dados['email'].toString();
        telefoneController.text = dados['telefone'].toString();
        aparelhoController.text = dados['aparelho'].toString();
        defeitoController.text = dados['defeito'].toString();
        selectedDate = dados['dataAbertura'].toDate();
        dataController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);
        titlePage = "Editando ficha nº $nextId";
      });
    }
  }

  void initState() {
    super.initState();

    setState(() {
      nomeController.clear();
      emailController.clear();
      telefoneController.clear();
      dataController.clear();
      aparelhoController.clear();
      defeitoController.clear();
      telefoneController.clear();
      dropValueStatus.value = 'Em aberto';

      if (widget.ficha != null) {
        recuperarDados();

        isButtonVisible = true;
      } else {
        isButtonVisible = false;
        dropValueStatus.value = dropOptionsStatus[0];
        proximoIdFicha();
      }
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

                // área do campo status
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

                // área do campo para pesquisar o nome do cliente
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
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: nomeController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                          prefixIconColor: AppColors.secondColor,
                          focusColor: AppColors.primaryOpacityColor,
                          hoverColor: AppColors.primaryOpacityColor),
                    ),
                    suggestionsCallback: (pattern) async {
                      // consulta o Firestore para obter sugestões com base no padrão fornecido
                      QuerySnapshot snapshot = await FirebaseFirestore.instance
                          .collection('clients')
                          .where('idUser', isEqualTo: userId)
                          .where('cliente', isGreaterThanOrEqualTo: pattern)
                          .where('cliente', isLessThan: pattern + 'z')
                          .limit(5)
                          .get();

                      // converte os documentos do Firestore em uma lista de strings
                      List<String> suggestions = [];
                      snapshot.docs.forEach((doc) {
                        suggestions.add(doc.get('cliente') as String);
                      });

                      return suggestions;
                    },
                    itemBuilder: (context, String suggestion) {
                      return ListTile(
                        leading: Icon(Icons.person,
                            color: AppColors.secondColor, size: 16),
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) async {
                      QuerySnapshot snapshot = await FirebaseFirestore.instance
                          .collection('clients')
                          .where('cliente', isEqualTo: suggestion)
                          .limit(1)
                          .get();

                      if (snapshot.docs.isNotEmpty) {
                        DocumentSnapshot selectedDoc = snapshot.docs.first;
                        setState(() {
                          nomeController.text =
                              selectedDoc.get('cliente') as String;
                          emailController.text =
                              selectedDoc.get('email') as String;
                          telefoneController.text =
                              selectedDoc.get('telefone') as String;
                        });
                      }
                    },
                  ),
                ),

                // área do campo e-mail
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

                // área do campo telefone
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

                // área do campo data de abertura
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

                // área do campo aparelho
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

                // área do campo defeito
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
                    maxLength: 200,
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
                          "Criar orçamento",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondColor),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateBudget(
                                      ficha: fichaId, orcamento: null)));
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
