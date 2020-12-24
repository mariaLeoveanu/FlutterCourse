import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

// Future<void> main() async {
//   final Response response = await get('https://www.worldometers.info/geography/flags-of-the-world/');
//   final String data = response.body;
//
//   final List<String> items = data.split('<a href="/img/flags');
//   for (final String item in items.skip(1)) {
//     final String imageURL = 'https://www.worldometers.info/img/flags${item.split('"')[0]}';
//     final String countryName = item.split('padding-top:10px">');
//     //print(imageURL);
//     print(item);
//   }
//   //File('./test.html').writeAsString(response.body);
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primaryColor: Colors.pinkAccent),
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: AnimatedContainer(
            duration: const Duration(seconds: 1),
            child: GridView.count(
                crossAxisCount: 3,
                children: List<Widget>.generate(9, (int i) {
                  return Container(
                      child: Text("haha"),
                  );
                }))));
  }
}
