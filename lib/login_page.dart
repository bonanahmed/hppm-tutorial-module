import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'main_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");

  Future _login() async {
    var url = 'https://reqres.in/api/login';
    var body = {
      'email': _emailController.text,
      'password': _passwordController.text
    };
    var response = await http.post(url, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    print(responseBody["token"]);
    if (responseBody["token"] != null) {
      Fluttertoast.showToast(msg: "Login Success");
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return MainPage();
        },
      ));
    } else {
      Fluttertoast.showToast(msg: "${responseBody['error']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        child: ListView(
          children: [
            Image(
              image: AssetImage("assets/src/img/logo-honda.png"),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Email/Username"),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Password"),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentColor,
                  child: Text("Login"),
                  onPressed: _login,
                  minWidth: MediaQuery.of(context).size.width,
                )),
          ],
        ),
      ),
    );
  }
}

class LoginResponse {
  final String token;
  LoginResponse({this.token});
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
    );
  }
}
