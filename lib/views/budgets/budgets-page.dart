// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist/model/budgets.dart';
import 'package:tech_assist/utils/appColors.dart';

class BudgetsPage extends StatefulWidget {
  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  var searchController = TextEditingController();

  List<Budgets> orcamentos = [
    Budgets('Lara Scaranello', 1, DateTime.now(), 'Iphone 11', 'Orçamento'),
    Budgets('Paulo Viana', 2, DateTime.now(), 'Samsung A31', 'Em aberto'),
    Budgets('Lucas Ribeiro', 3, DateTime.now(), 'Iphone 8', 'Fechado'),
    Budgets('Laura Silva', 4, DateTime.now(), 'Samsung S10', 'Em execução'),
  ];

  final dropValueStatus = ValueNotifier('');
  final dropOptionsStatus = [
    'Aguardando aprovação',
    'Em andamento',
    'Finalizado',
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Container(
          margin: EdgeInsets.only(top: 60),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Orçamentos",
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
                        width: 320,
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
                              hintText:
                                  "Número do orçamento ou nome do cliente",
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
                                  width: 1, color: AppColors.secondColor)),
                          child: Center(
                              child: Icon(Icons.search,
                                  color: AppColors.secondColor)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 2),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Filtrar por",
                      style: GoogleFonts.montserrat(
                          fontSize: 16, color: AppColors.textColorBlack),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 48),
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
                              dropdownColor: AppColors.primaryOpacityColor,
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down),
                              hint: Text(
                                "Status",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: AppColors.textColorBlack,
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
                                dropdownColor: AppColors.primaryOpacityColor,
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down),
                                hint: Text(
                                  "Mês",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: AppColors.textColorBlack,
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
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 72,
                        height: 40,
                        child: ValueListenableBuilder(
                            valueListenable: dropValueYear,
                            builder: (BuildContext context, String value, _) {
                              return DropdownButtonFormField<String>(
                                dropdownColor: AppColors.primaryOpacityColor,
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down),
                                hint: Text(
                                  "Ano",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: AppColors.textColorBlack,
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
                      padding: EdgeInsets.only(left: 8),
                      child: Container(
                        width: 38,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: AppColors.secondColor)),
                        child: Center(
                            child: Icon(Icons.filter_alt,
                                color: AppColors.secondColor)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: orcamentos.length,
                      itemBuilder: (context, index) =>
                          buildBudget(orcamentos[index])),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    backgroundColor: AppColors.secondColor,
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/create-budget'),
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // método que cria a lista de orçamentos
  Widget buildBudget(Budgets obj) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/edit-budget');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(width: 1, color: AppColors.secondColor)),
        child: ListTile(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    obj.cliente,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColorBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "N° " + obj.numFicha.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
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
                      size: 14,
                      color: AppColors.secondColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        obj.dataAbertura.toString().substring(0, 10),
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: AppColors.textColorGrey2),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.build,
                        size: 14,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          obj.aparelho,
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: AppColors.textColorGrey2),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 14,
                        color: AppColors.green,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          obj.status,
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: AppColors.textColorGrey2),
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
  }
}
