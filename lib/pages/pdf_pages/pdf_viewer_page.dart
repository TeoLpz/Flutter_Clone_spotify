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
      backgroundColor: Colors.black, // Fondo oscuro
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            const SizedBox(width: 10),
            const Text(
              'PDF Viewer',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.green, // Color verde estilo Spotify
                    ),
                  )
                : localPath.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[850], // Fondo oscuro para PDF
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(8),
                        child: PDFView(
                          filePath: localPath,
                          enableSwipe: true,
                          swipeHorizontal: true,
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Error al cargar el PDF",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
