import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NutritionInputPage extends StatefulWidget {
  const NutritionInputPage({super.key, required this.currentDate});

  final String currentDate;

  @override
  _NutritionInputPageState createState() => _NutritionInputPageState();
}

class _NutritionInputPageState extends State<NutritionInputPage> {
  List<TextEditingController> _controllers = [TextEditingController()];

  void _addNewTextField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nutrition at ${widget.currentDate}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Eingabe ${index + 1}',
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addNewTextField,
              child: Text('Speichern und neues Feld hinzufügen'),
            ),
          ],
        ),
      ),
    );
  }
}
