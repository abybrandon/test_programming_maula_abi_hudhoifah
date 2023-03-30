// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://hiringmobile.qtera.co.id/city?province=6392ea3453bd8aa1069ba3b6'));
    final data = jsonDecode(response.body)['data'];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data'),
        ),
        body: Center(
            child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var provinsiPertama =
                  snapshot.data[0]['name']; // Mengambil data provinsi pertama
              return Text(provinsiPertama);
            } else if (snapshot.hasError) {
              return Text("Error");
            } else {
              return CircularProgressIndicator();
            }
          },
        )),
      ),
    );
  }
}
