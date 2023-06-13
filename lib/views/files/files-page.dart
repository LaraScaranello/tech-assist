// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist/main.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'package:tech_assist/views/files/create-file.dart';
import 'package:intl/intl.dart';

class FilesPage extends StatefulWidget {
  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  var searchController = TextEditingController();
  var dataInicioController = TextEditingController();
  var dataFimController = TextEditingController();

  String buscaCliente = '';
  DateTime selectedDateIni = DateTime.now();
  DateTime selectedDateFim = DateTime.now();
  String hintTextStatus = 'Status';

  final dropValueStatus = ValueNotifier('');
  final dropOptionsStatus = [
    'Geral',
    'Em aberto',
    'Orçamento',
    'Em execução',
    'Fechado',
    'Cancelado'
  ];

  void _selectDateIni(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateIni,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDateIni) {
      setState(() {
        selectedDateIni = pickedDate;
        dataInicioController.text =
            DateFormat('yyyy-MM-dd').format(selectedDateIni);
      });
    }
  }

  void _selectDateFim(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateFim,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDateFim) {
      setState(() {
        selectedDateFim = pickedDate;
        dataFimController.text =
            DateFormat('yyyy-MM-dd').format(selectedDateFim);
      });
    }
  }

  void limpaFiltros(BuildContext context) async {
    setState(() {
      buscaCliente = '';
      searchController.clear();
      dropValueStatus.value = dropOptionsStatus[0];
      dataInicioController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.parse('2000-01-01'));
      dataFimController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.parse('2100-01-01'));
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      buscaCliente = '';
      dataInicioController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.parse('2000-01-01'));
      dataFimController.text =
          DateFormat('yyyy-MM-dd').format(DateTime.parse('2100-01-01'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: Container(
          margin: EdgeInsets.only(top: 60),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Fichas de atendimento",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 24,
                          color: AppColors.secondColor,
                          fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 180,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.primaryOpacityColor,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: TextField(
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textColorBlack)),
                          controller: searchController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "Nome do cliente",
                              contentPadding: EdgeInsets.all(8),
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: AppColors.textColorBlack)),
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 180,
                        height: 40,
                        child: ValueListenableBuilder(
                            valueListenable: dropValueStatus,
                            builder: (BuildContext context, String value, _) {
                              return DropdownButtonFormField<String>(
                                dropdownColor: AppColors.primaryOpacityColor,
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down),
                                hint: Text(
                                  hintTextStatus,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: AppColors.textColorBlack,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  contentPadding: EdgeInsets.all(4),
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 22, right: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 180,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.primaryOpacityColor,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: TextField(
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textColorBlack)),
                          readOnly: true,
                          onTap: () => _selectDateIni(context),
                          controller: dataInicioController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "Data início",
                              contentPadding: EdgeInsets.all(8),
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: AppColors.textColorBlack)),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 180,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.primaryOpacityColor,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: TextField(
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textColorBlack)),
                          readOnly: true,
                          onTap: () => _selectDateFim(context),
                          controller: dataFimController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "Data fim",
                              contentPadding: EdgeInsets.all(8),
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: AppColors.textColorBlack)),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8, bottom: 10, top: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            buscaCliente = searchController.text;
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: AppColors.secondColor)),
                          child: Center(
                              child: Icon(Icons.search,
                                  color: AppColors.secondColor)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20, bottom: 10, top: 8),
                      child: GestureDetector(
                        onTap: () {
                          limpaFiltros(context);
                        },
                        child: Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: AppColors.secondColor)),
                          child: Center(
                              child: Icon(Icons.cleaning_services,
                                  color: AppColors.textColorRed)),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('files')
            .where('idUser', isEqualTo: userId)
            .orderBy('cliente')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<QueryDocumentSnapshot<Object?>> filteredDocuments = [];

          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(right: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        backgroundColor: AppColors.secondColor,
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/create-file'),
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            if (buscaCliente.isNotEmpty &&
                dropValueStatus.value.isNotEmpty &&
                dropValueStatus.value != 'Geral') {
              filteredDocuments = snapshot.data!.docs.where((doc) {
                DateTime dataAbertura = doc['dataAbertura'].toDate();
                DateTime dataInicioFiltro =
                    DateTime.parse(dataInicioController.text);
                DateTime dataFimFiltro = DateTime.parse(dataFimController.text);

                return doc['cliente'] == buscaCliente &&
                    doc['status'] == dropValueStatus.value &&
                    (dataAbertura.isAfter(dataInicioFiltro) ||
                        dataAbertura.isAtSameMomentAs(dataInicioFiltro)) &&
                    (dataAbertura.isBefore(dataFimFiltro) ||
                        dataAbertura.isAtSameMomentAs(dataFimFiltro));
              }).toList();
            } else if (buscaCliente.isNotEmpty) {
              filteredDocuments = snapshot.data!.docs.where((doc) {
                DateTime dataAbertura = doc['dataAbertura'].toDate();
                DateTime dataInicioFiltro =
                    DateTime.parse(dataInicioController.text);
                DateTime dataFimFiltro = DateTime.parse(dataFimController.text);

                return doc['cliente'] == buscaCliente &&
                    (dataAbertura.isAfter(dataInicioFiltro) ||
                        dataAbertura.isAtSameMomentAs(dataInicioFiltro)) &&
                    (dataAbertura.isBefore(dataFimFiltro) ||
                        dataAbertura.isAtSameMomentAs(dataFimFiltro));
              }).toList();
            } else if (dropValueStatus.value.isNotEmpty &&
                dropValueStatus.value != 'Geral') {
              filteredDocuments = snapshot.data!.docs.where((doc) {
                DateTime dataAbertura = doc['dataAbertura'].toDate();
                DateTime dataInicioFiltro =
                    DateTime.parse(dataInicioController.text);
                DateTime dataFimFiltro = DateTime.parse(dataFimController.text);

                return doc['status'] == dropValueStatus.value &&
                    (dataAbertura.isAfter(dataInicioFiltro) ||
                        dataAbertura.isAtSameMomentAs(dataInicioFiltro)) &&
                    (dataAbertura.isBefore(dataFimFiltro) ||
                        dataAbertura.isAtSameMomentAs(dataFimFiltro));
              }).toList();
            } else {
              filteredDocuments = snapshot.data!.docs.where((doc) {
                DateTime dataAbertura = doc['dataAbertura'].toDate();
                DateTime dataInicioFiltro =
                    DateTime.parse(dataInicioController.text);
                DateTime dataFimFiltro = DateTime.parse(dataFimController.text);

                return (dataAbertura.isAfter(dataInicioFiltro) ||
                        dataAbertura.isAtSameMomentAs(dataInicioFiltro)) &&
                    (dataAbertura.isBefore(dataFimFiltro) ||
                        dataAbertura.isAtSameMomentAs(dataFimFiltro));
              }).toList();
            }
          }

          return Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: filteredDocuments.map(
                          (DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateFile(
                                              ficha: document.id,
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                        width: 1,
                                        color: AppColors.secondColor)),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data['cliente'],
                                            style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textColorBlack,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "N° " + data['numFicha'].toString(),
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textColorGrey2,
                                            ),
                                            //textDirection: TextDirection.LTR,
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.watch_later_outlined,
                                              size: 14,
                                              color: AppColors.secondColor,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                DateFormat('yyyy-MM-dd').format(
                                                    data['dataAbertura']
                                                        .toDate()),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: AppColors
                                                        .textColorGrey2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.build,
                                                size: 14,
                                                color: AppColors.secondColor,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  data['aparelho'],
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      color: AppColors
                                                          .textColorGrey2),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              FutureBuilder<Color>(
                                                future:
                                                    retCorFicha(data['status']),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return CircularProgressIndicator();
                                                  }
                                                  if (snapshot.hasData) {
                                                    Color corFicha =
                                                        snapshot.data!;
                                                    return Icon(
                                                      Icons.circle,
                                                      size: 14,
                                                      color: corFicha,
                                                    );
                                                  }
                                                  return Container(); // Return a placeholder widget if no data is available
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  data['status'],
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      color: AppColors
                                                          .textColorGrey2),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        backgroundColor: AppColors.secondColor,
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/create-file'),
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
