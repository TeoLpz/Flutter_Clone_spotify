import 'package:flutter/material.dart';
import 'pdf_viewer_page.dart';

class PdfListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de PDFs'),
      ),
      body: ListView(
        children: [
          buildPdfListTile(context, 'Manual JAVA', 'https://www.uneweb.com/tutoriales/JAVA/java.%20pdf.pdf'),
          buildPdfListTile(context, 'El Principito', 'https://web.seducoahuila.gob.mx/biblioweb/upload/Antoine%20De%20Saint-Exup%C3%A9ry%20-%20El%20principito.pdf'),
          buildPdfListTile(context, 'Verbos irregulares ING', 'https://www.uv.mx/pozarica/caa-conta/files/2016/02/REGULAR-AND-IRREGULAR-VERBS.pdf'),
          // Agrega más PDFs aquí
        ],
      ),
    );
  }

  Widget buildPdfListTile(BuildContext context, String title, String pdfUrl) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.picture_as_pdf),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PdfViewerPage(pdfUrl: pdfUrl)),
        );
      },
    );
  }
}
