// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_assist/main.dart';
import 'package:tech_assist/utils/appColors.dart';
import 'package:tech_assist/views/clients/create-client.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  var searchController = TextEditingController();
  bool inativos = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(170),
        child: Container(
          margin: EdgeInsets.only(top: 60),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Clientes",
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
                                borderRadius: BorderRadius.circular(4),
                              ),
                              hintText: "Nome do cliente",
                              contentPadding: EdgeInsets.all(8),
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 14,
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Checkbox(
                          value: inativos,
                          activeColor: AppColors.secondColor,
                          onChanged: (bool? valor) {
                            setState(() {
                              inativos = valor!;
                            });
                          }),
                      Text(
                        "Incluir inativos",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 12, color: AppColors.textColorBlack),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('clients')
            .where('idUser', isEqualTo: userId)
            .where('status', isEqualTo: inativos ? null : true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: FloatingActionButton(
                  backgroundColor: AppColors.secondColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/create-client'),
                  child: Icon(Icons.add),
                ),
              ),
            );
          }

          return Container(
            width: double.infinity,
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 40),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: snapshot.data!.docs.map(
                          (DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateClient(
                                              cliente: document.id,
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
                                            MainAxisAlignment.start,
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
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: 14,
                                              color: AppColors.secondColor,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                data['telefone'],
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    color: AppColors
                                                        .textColorGrey2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.email,
                                              size: 14,
                                              color: AppColors.secondColor,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                data['email'],
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    color: AppColors
                                                        .textColorGrey2),
                                              ),
                                            ),
                                          ],
                                        ),
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
                            Navigator.of(context).pushNamed('/create-client'),
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
