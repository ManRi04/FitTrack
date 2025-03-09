import 'package:fit_track/app/Timer.dart';
import 'package:flutter/material.dart';

import 'Challenges.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding für den gesamten Inhalt
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Text links ausrichten
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
              SizedBox(height: 20), // Abstand zum nächsten Element
              // Vorname
              Text(
                "Vorname: Max",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
        
              // Nachname
              Text(
                "Nachname: Mustermann",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 130,
                  vertical: 30,
                ),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF740F77),
                      minimumSize: Size(20, 50),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfilPage()),
                      );
                    },
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      softWrap: false,
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.fitness_center, size: 30), // Das Icon für den Button
                label: Text('Go to Challenges'), // Der Text für den Button
                onPressed: () {
                  // Navigiere zur ChallengesPage, wenn der Button gedrückt wird
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChallengesPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal, // Textfarbe des Buttons
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Abgerundete Ecken
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              SizedBox(height: 50,),
              ElevatedButton.icon(
                icon: Icon(Icons.timer, size: 30), // Das Icon für den Button
                label: Text('Timer'), // Der Text für den Button
                onPressed: () {
                  // Navigiere zur ChallengesPage, wenn der Button gedrückt wird
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimerPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.teal, // Textfarbe des Buttons
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Abgerundete Ecken
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
        
              ],
          ),
        ),
      ),
    );
  }
}

class EditProfilPage extends StatefulWidget {
  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  final _formKey = GlobalKey<FormState>();
  String vorname = "Max";
  String nachname = "Mustermann";
  String email = "max.mustermann@example.com";
  String geburtsdatum = "01.01.1990";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(title: Text("Profil bearbeiten")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                buildTextField("Vorname", vorname, (value) => vorname = value),
                SizedBox(height: 10),
                buildTextField("Nachname", nachname, (value) => nachname = value),
                SizedBox(height: 10),
                buildTextField(
                  "E-Mail",
                  email,
                  (value) => email = value,
                  isEmail: true,
                ),
                SizedBox(height: 10),
                buildTextField(
                  "Geburtsdatum",
                  geburtsdatum,
                  (value) => geburtsdatum = value,
                ),
                SizedBox(height: 50),
      
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Speichern"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    String initialValue,
    Function(String) onSaved, {
    bool isEmail = false,
  }) {
    return TextFormField(
      initialValue: initialValue,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      validator:
          (value) => value!.isEmpty ? "$label darf nicht leer sein" : null,
      onSaved: (value) => onSaved(value!),
    );
  }
}
