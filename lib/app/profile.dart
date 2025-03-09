import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // Padding für den gesamten Inhalt
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // Text links ausrichten
          children: [
            // Profilbild oder Icon
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.account_circle,
                  size: 70,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),  // Abstand zum nächsten Element

            // Vorname
            Text(
              "Vorname: Max",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 10),

            // Nachname
            Text(
              "Nachname: Mustermann",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),

            // Weitere Zeilen (z.B. E-Mail oder Geburtsdatum)
            Text(
              "E-Mail: max.mustermann@example.com",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 10),

            // Platz für weitere Informationen
            Text(
              "Geburtsdatum: 01.01.1990",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),

            // Weitere Zeilen können hier hinzugefügt werden
            Text(
              "Weitere Infos: Hier kann ein zusätzlicher Text stehen.",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

