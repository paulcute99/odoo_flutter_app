import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Odoo Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Odoo Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: getListView(),
      ),
    );
  }

  ListView getListView() => ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    return GestureDetector(
      // When the child is tapped, show a snackbar
      onTap: () {},
      // Our Custom Button!
      child: new Container(
        // color: Colors.blue,
        padding: const EdgeInsets.all(10.0),
        width: 380.0,
        height: 300.0,
        child: Card(
          child: Container(
              child: new Row(children: [
            new Column(children: [
              new Image.asset('assets/images/placeholder.jpg',
                  width: 383.0, height: 150.0, fit: BoxFit.cover),
            ]),
          ])),
        ),
      ),
    );
  }

  List<HashMap<String, String>> list;
  bool flagProgress = true;

  Future<Null> loadData() async {
    final response = await http.get('http://localhost:8080/api/books');

    if (response.statusCode == 200) {
      debugPrint(response.body);
      if (json.decode(response.body)["success"] == 1) {
        setState(() {
          list = json.decode(response.body)["data"];
          flagProgress = false;
        });
      } else {
        setState(() {
          flagProgress = false;
        });
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load books');
    }
  }
}
