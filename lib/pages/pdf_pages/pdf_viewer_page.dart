import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl;

  PdfViewerPage({required this.pdfUrl});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String localPath = "";
  bool loading = true;

  @override
  void initState() {
    super.initState();
    downloadPdf();
  }

  Future<void> downloadPdf() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/temp.pdf");

      await Dio().download(widget.pdfUrl, file.path);
      setState(() {
        localPath = file.path;
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visor de PDF'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : localPath.isNotEmpty
              ? PDFView(
                  filePath: localPath,
                )
              : Center(child: Text("Error al cargar el PDF")),
    );
  }
}
