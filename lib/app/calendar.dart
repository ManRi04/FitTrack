import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'progress.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  TextEditingController _controller = TextEditingController();
  Map<DateTime, String> _eventNotes = {};

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _controller.text =
          _eventNotes[day] ??
          ''; // Falls ein Text für den Tag existiert, laden.
    });
  }

  void _saveEvent() {
    setState(() {
      // Speichert den Text mit dem entsprechenden Datum
      _eventNotes[today] = _controller.text;
    });
    // Zeigt eine Bestätigungsmeldung
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Note saved for ${today.toLocal()}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Here are your training plans")),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Text("Calendar"),
        Container(
          child: TableCalendar(
            locale: "en_US",
            rowHeight: 43,
            focusedDay: today,
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            onDaySelected: _onDaySelected,
          ),
        ),
        SizedBox(height: 20), // Abstand zwischen Kalender und Textfeld
        if (today != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText:
                    'Enter your note for ${today.day}/${today.month}/${today.year}',
                border: OutlineInputBorder(),
              ),
              maxLines: 3, // Textfeld auf 3 Zeilen beschränken
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _saveEvent, child: Text("Save Note")),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // Navigation zur neuen Seite
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProgressPage(title: today.toString().split("00:00:00.000Z")[0]),
                ),
              );
            },
            child: Text("Open progress"),
          ),
        ],
      ],
    );
  }
}
