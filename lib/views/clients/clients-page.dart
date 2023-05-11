// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist/model/clients.dart';
import 'package:tech_assist/utils/appColors.dart';

class ClientsPage extends StatefulWidget {
  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  var searchController = TextEditingController();

  List<Clients> orcamentos = [
    Clients('Lara Scaranello', '(17)5555-5555', 'lara@gmail.com'),
    Clients('Lucas Ribeiro', '(17)4444-5555', 'lucas@gmail.com'),
    Clients('Paulo Viana', '(17)3333-5555', 'paulo@gmail.com'),
    Clients('Laura Silva', '(17)2222-5555', 'laura@gmail.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 70),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Clientes",
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
                      width: 320,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.primaryOpacityColor,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: TextField(
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 16, color: AppColors.textColorBlack)),
                        controller: searchController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4)),
                            hintText: "Nome do cliente",
                            contentPadding: EdgeInsets.all(15),
                            hintStyle: GoogleFonts.montserrat(
                                fontSize: 12, color: AppColors.textColorBlack)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: 38,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                        Navigator.of(context).pushNamed('/create-client'),
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

  // método que cria a lista de fichas de atendimento
  Widget buildBudget(Clients obj) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/edit-client');
      },
      child: Expanded(
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          obj.telefone,
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: AppColors.textColorGrey2),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 12,
                        color: AppColors.secondColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          obj.email,
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: AppColors.textColorGrey2),
                        ),
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
