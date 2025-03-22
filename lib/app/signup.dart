import 'package:fit_track/app/login.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _users = Hive.box('users');

  final _formKey = GlobalKey<FormState>(); // Form-Key zur Validierung
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  var _availableKey = 1;

  void createUser() {
    while (_users.containsKey(_availableKey)) {
      _availableKey++;
    }
    _users.put(_availableKey, {
      'email': _emailController.text,
      'password': _passwordController.text,
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Registrierung erfolgreich!")));

    print(_users.get(_availableKey));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      createUser(); // Nutzer speichern
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bitte alle Felder korrekt ausfüllen!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up Screen")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Form-Widget mit Key für Validierung
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Email Feld
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Bitte eine E-Mail eingeben";
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Bitte eine gültige E-Mail eingeben";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Passwort Feld
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Bitte ein Passwort eingeben";
                  } else if (value.length < 6) {
                    return "Passwort muss mindestens 6 Zeichen lang sein";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Passwort bestätigen
              TextFormField(
                controller: _passwordConfirmController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Confirm Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Bitte Passwort bestätigen";
                  } else if (value != _passwordController.text) {
                    return "Passwörter stimmen nicht überein";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Sign Up Button
              MaterialButton(
                minWidth: double.infinity,
                onPressed: _submitForm,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Sign Up"),
              ),
              SizedBox(height: 20),

              // Log in Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text("Log in", style: TextStyle(color: Colors.teal)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
