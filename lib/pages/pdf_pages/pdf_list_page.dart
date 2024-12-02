import 'package:flutter/material.dart';
import 'pdf_viewer_page.dart';

class PdfListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de PDFs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF121212), // Fondo oscuro típico de Spotify
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFF121212), // Fondo oscuro
        child: ListView(
          children: [
            buildPdfListTile(
              context,
              'Manual JAVA',
              'https://www.uneweb.com/tutoriales/JAVA/java.%20pdf.pdf',
            ),
            buildPdfListTile(
              context,
              'El Principito',
              'https://web.seducoahuila.gob.mx/biblioweb/upload/Antoine%20De%20Saint-Exup%C3%A9ry%20-%20El%20principito.pdf',
            ),
            buildPdfListTile(
              context,
              'Verbos irregulares ING',
              'https://www.uv.mx/pozarica/caa-conta/files/2016/02/REGULAR-AND-IRREGULAR-VERBS.pdf',
            ),
            // Agrega más PDFs aquí
          ],
        ),
      ),
    );
  }

  Widget buildPdfListTile(BuildContext context, String title, String pdfUrl) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E), // Color oscuro para las tarjetas
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          Icons.picture_as_pdf,
          color: Color(0xFF1DB954), // Verde Spotify
          size: 32,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 20,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerPage(pdfUrl: pdfUrl),
            ),
          );
        },
      ),
    );
  }
}
