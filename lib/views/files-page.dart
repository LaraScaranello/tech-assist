// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist/utils/appColors.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  var searchController = TextEditingController();
  String client = 'Lara Scaranello';
  String numFile = '120';
  String dateOpened = '02/05/2023';
  String device = 'iPhone 11';
  String status = 'Em execução';

  final dropValueStatus = ValueNotifier('');
  final dropOptionsStatus = [
    'Aberto',
    'Orçamento',
    'Em execução',
    'Fechado',
    'Cancelado'
  ];
  final dropValueMonth = ValueNotifier('');
  final dropOptionsMonth = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];
  final dropValueYear = ValueNotifier('');
  final dropOptionsYear = [
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fichas de atendimento",
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: AppColors.titleColorBlack,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 266,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.primaryOpacityColor,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "Número da ficha ou nome do cliente",
                              contentPadding: EdgeInsets.all(15),
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: AppColors.textColorBlack)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          width: 38,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: AppColors.bottomBar)),
                          child: Center(
                              child: Icon(Icons.search,
                                  color: AppColors.bottomBar)),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Filtrar por",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: AppColors.textColorBlack),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 104,
                        height: 40,
                        child: ValueListenableBuilder(
                            valueListenable: dropValueStatus,
                            builder: (BuildContext context, String value, _) {
                              return DropdownButtonFormField<String>(
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down),
                                hint: Text(
                                  "Status",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SizedBox(
                          width: 94,
                          height: 40,
                          child: ValueListenableBuilder(
                              valueListenable: dropValueMonth,
                              builder: (BuildContext context, String value, _) {
                                return DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  hint: Text(
                                    "Mês",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
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
                                      dropValueMonth.value = escolha.toString(),
                                  items: dropOptionsMonth
                                      .map(
                                        (op) => DropdownMenuItem(
                                          value: op,
                                          child: Text(
                                            op,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color:
                                                    AppColors.textColorBlack),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SizedBox(
                          width: 72,
                          height: 40,
                          child: ValueListenableBuilder(
                              valueListenable: dropValueYear,
                              builder: (BuildContext context, String value, _) {
                                return DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  hint: Text(
                                    "Ano",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
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
                                      dropValueYear.value = escolha.toString(),
                                  items: dropOptionsYear
                                      .map(
                                        (op) => DropdownMenuItem(
                                          value: op,
                                          child: Text(
                                            op,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color:
                                                    AppColors.textColorBlack),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Container(
                          width: 38,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: AppColors.bottomBar)),
                          child: Center(
                              child: Icon(Icons.filter_alt,
                                  color: AppColors.bottomBar)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  height: 105,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.white,
                      border: Border.all(width: 1, color: AppColors.bottomBar)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            client,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColorBlack,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "N° " + numFile,
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColorGrey2,
                            ),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              size: 12,
                              color: AppColors.bottomBar,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                dateOpened,
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: AppColors.textColorGrey2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.build,
                            size: 12,
                            color: AppColors.bottomBar,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  device,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: AppColors.textColorGrey2),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: AppColors.green,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        status,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: AppColors.textColorGrey2),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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
