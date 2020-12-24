import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Is it square or is is cube',
      theme: ThemeData(primaryColor: Colors.grey),
      home: const MyHomePage(title: 'Is it square or is is cube'),
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
  final String displayMessage = 'Enter a number to see if it is either a perfect square, or a perfect cube';
  String errorMessage;
  int number;
  TextEditingController controller = TextEditingController();

  void validate() {
    const String isSquare = 'The given number is a perfect square. ';
    const String isCube = 'The given number is a perfect cube';
    String answer = '';

    // check if it is perfect square
    if (sqrt(number) == sqrt(number).toInt()) {
      answer = isSquare;
    }

    // check if it is perfect cube
    for (int i = 1; i < number; i++) {
      if (i * i * i == number) {
        i = number + 1;
        answer += isCube;
      }
    }

    if (answer.isEmpty) {
      answer = 'The given number is neither a perfect square nor a perfect cube.';
    }

    showResult(answer);
  }

  void showResult(String message) {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text(message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
              child: Text(displayMessage),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: TextField(
                controller: controller,
                onChanged: (String input) {
                  setState(() {
                    if (double.tryParse(input) == null) {
                      errorMessage = 'Enter digits only!';
                    } else {
                      errorMessage = null;
                      number = int.parse(input);
                    }
                  });
                },
                decoration: InputDecoration(hintText: 'Enter a number', errorText: errorMessage),
              ),
            ),
            RaisedButton(
              onPressed: () {
                validate();
              },
              elevation: 13,
              child: const Text('CHECK'),
            )
          ],
        ),
      ),
    );
  }
}
