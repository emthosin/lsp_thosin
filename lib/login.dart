import 'package:flutter/material.dart';
import 'package:lsp_thosin/database/databaseHelper.dart';
import 'package:lsp_thosin/home.dart';
import 'package:lsp_thosin/register.dart';

class LoginPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.grey.shade700,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(height: 50),
          Icon(
            Icons.price_check,
            size: 200,
            color: Colors.orangeAccent,
          ),
          SizedBox(height: 50),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.grey.shade700),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey.shade700),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // Grey border for focused state
                ),
              ),
              obscureText: true,
            ),
          ),
          SizedBox(height: 40),
          TextButton(
            onPressed: () async {
              if (usernameController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Data tidak boleh kosong.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                          ),
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                DatabaseHelper().login(
                    usernameController.text, passwordController.text, context);
              }
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              child: Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
