import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutPlanPage extends StatefulWidget {
  const WorkoutPlanPage({super.key, required this.currentDate});

  final String currentDate;

  @override
  _WorkoutPlanPageState createState() => _WorkoutPlanPageState();
}

class _WorkoutPlanPageState extends State<WorkoutPlanPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout plan at ${widget.currentDate}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          maxLines: null, // Ermöglicht unbegrenzte Zeilen
          style: TextStyle(fontSize: 18.0),
          decoration: InputDecoration(
            border: InputBorder.none, // Entfernt den sichtbaren Rahmen
            hintText: 'Hier schreiben...',
          ),
        ),
      ),
    );
  }
}
