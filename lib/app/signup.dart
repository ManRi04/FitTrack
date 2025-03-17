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

  var _availableKey =1;
  var _email= "";
  var _passwordFirst= "";
  var _passwordConfirm = "";

  void createUser(){
       while(_users.containsKey(_availableKey)){
         _availableKey++;
       }
      _users.put(_availableKey,{'email':_email, 'password': _passwordFirst});
       print(_users.get(_availableKey));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up Screen")),
      body: Column(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                // Email Text Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return value!.isEmpty ? "Please enter email" : null;
                    },
                    onChanged: (value){
                      _email = value.toString();
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Password Text Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    obscureText: true, // Verbirgt das Passwort
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return value!.isEmpty ? "Please enter password" : null;
                    },
                    onChanged: (value){
                      _passwordFirst = value.toString();
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Confirm Password Text Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    obscureText: true, // Verbirgt das Passwort
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return value!.isEmpty
                          ? "Please confirm your password"
                          : null;
                    },
                    onChanged: (value){
                      _passwordConfirm = value.toString();
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Sign Up Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                        if(_email.isEmpty || _passwordFirst.isEmpty || _passwordConfirm.isEmpty
                        || _passwordFirst!=_passwordConfirm){

                        }

                        // Navigation zur neuen Seite nach erfolgreicher Validierung
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    ,
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Text("Sign Up"),
                  ),
                ),

                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigation zur Sign Up Seite
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
