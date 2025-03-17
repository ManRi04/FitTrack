import 'package:fit_track/app/progress.dart';
import 'package:fit_track/app/signup.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _usersBox = Hive.box('users');

  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // Überprüfe, ob die E-Mail in der Datenbank existiert
      bool emailExists = false;
      dynamic userKey;

      for (var key in _usersBox.keys) {
        var user = _usersBox.get(key);
        if (user['email'] == email) {
          emailExists = true;
          userKey = key;
          break;
        }
      }

      if (!emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("E-Mail nicht gefunden!")),
        );
        return;
      }

      // Überprüfe das Passwort
      var userData = _usersBox.get(userKey);
      if (userData['password'] != password) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Falsches Passwort!")),
        );
        return;
      }

      // Login erfolgreich -> Weiterleitung zur nächsten Seite
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenSwiperPage(title: "Today"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 35, color: Colors.teal, fontWeight: FontWeight.bold),
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

              // Login Button
              MaterialButton(
                minWidth: double.infinity,
                onPressed: _login,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Login"),
              ),
              SizedBox(height: 20),

              // No account? Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text("Sign Up", style: TextStyle(color: Colors.teal)),
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
