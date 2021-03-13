import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List _dataUsers = [];
  Future<Map<String, dynamic>> _getUsers() async {
    var url = 'https://reqres.in/api/users';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      _dataUsers = responseBody['data'];
      return responseBody;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _dataUsers.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                    '${_dataUsers[index]['first_name']} ${_dataUsers[index]['last_name']}'),
                subtitle: Text(_dataUsers[index]['email']),
                leading:
                    Image(image: NetworkImage(_dataUsers[index]['avatar'])),
              ),
            );
          },
        ),
      ),
    );
  }
}
