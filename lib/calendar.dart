import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // Aktuell ausgewählter Tag
  DateTime _selectedDay = DateTime.now();

  // Ein Map für Termine je Tag
  Map<DateTime, List<String>> _events = {};

  // ValueNotifier für die Termine des ausgewählten Tages
  late ValueNotifier<List<String>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  // Gibt die Events für den ausgewählten Tag zurück
  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  // Fügt ein Event für den ausgewählten Tag hinzu
  void _addEvent(DateTime day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _eventController = TextEditingController();
        return AlertDialog(
          title: Text('Neues Event für ${day.toLocal()}', style: TextStyle(color: Colors.white, fontSize: 18.0)),
          content: TextField(
            controller: _eventController,
            decoration: InputDecoration(hintText: 'Eventbeschreibung', hintStyle: TextStyle(color: Colors.white)),
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String event = _eventController.text;
                if (event.isNotEmpty) {
                  setState(() {
                    if (_events[day] == null) {
                      _events[day] = [];
                    }
                    _events[day]?.add(event);
                    _selectedEvents.value = _getEventsForDay(day);
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Hinzufügen', style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,  // Hintergrundfarbe auf schwarz gesetzt
      appBar: AppBar(
        title: Text('Kalender', style: TextStyle(color: Colors.white, fontSize: 18.0)),  // Weißer Text in der AppBar
        backgroundColor: Colors.white,  // AppBar Hintergrundfarbe auf schwarz gesetzt
      ),
      body: Column(
        children: [
          // Kalenderansicht
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);
              });
            },
            onPageChanged: (focusedDay) {
              // Fokus aktualisieren, wenn die Seite geändert wird
              _selectedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
              selectedTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
              todayDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
              formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            ),
          ),
          SizedBox(height: 8.0),

          // Zeigt die Events des ausgewählten Tages an
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _selectedEvents,
              builder: (context, events, _) {
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(events[index], style: TextStyle(color: Colors.white, fontSize: 18.0)),  // Weißer Text für Events
                    );
                  },
                );
              },
            ),
          ),

          // Button zum Hinzufügen von Terminen
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _addEvent(_selectedDay),
              child: Text('Event hinzufügen', style: TextStyle(color: Colors.white, fontSize: 18.0)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,  // Hintergrundfarbe des Buttons
              ),
            ),
          ),
        ],
      ),
    );
  }
}
