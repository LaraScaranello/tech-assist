import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:share_extend/share_extend.dart';
import 'package:tech_assist/utils/appColors.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfPath;

  PDFViewerScreen({required this.pdfPath});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Visualizador de PDF'),
          backgroundColor: AppColors.secondColor,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  ShareExtend.share(widget.pdfPath, "file",
                      sharePanelTitle: "Enviar Orçamento");
                },
                icon: Icon(Icons.share))
          ]),
      body: PDFView(
        filePath: widget.pdfPath,
      ),
    );
  }
}
