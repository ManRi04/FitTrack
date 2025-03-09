import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChallengesPage extends StatefulWidget {
  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  // Beispiel-Daten für Challenges
  final List<Map<String, String>> challenges = [
    {
      'title': '10.000 Schritte',
      'description': 'Gehe jeden Tag 10.000 Schritte.',
    },
    {
      'title': '5 km Laufen',
      'description': 'Laufe 5 km in dieser Woche.',
    },
    {
      'title': 'Woche ohne Zucker',
      'description': 'Verzichte eine Woche lang auf Zucker.',
    },
    {
      'title': '30 Tage Fitness',
      'description': 'Trainiere jeden Tag für 30 Minuten.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            return ChallengeCard(
              title: challenges[index]['title']!,
              description: challenges[index]['description']!,
              onStart: () {
                // Hier kannst du weitere Logik einbauen, z. B. den Status der Challenge ändern
                print('Challenge gestartet: ${challenges[index]['title']}');
              },
            );
          },
        ),
      ),
    );
  }
}

class ChallengeCard extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onStart;

  const ChallengeCard({
    required this.title,
    required this.description,
    required this.onStart,
  });

  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  bool isStarted = false; // Status, ob die Challenge gestartet wurde

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isStarted = true; // Markiere die Challenge als gestartet
                });
                widget.onStart(); // Aufrufen der externen Funktion
              },
              child: Text(isStarted ? 'Challenge gestartet' : 'Starte Challenge'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
