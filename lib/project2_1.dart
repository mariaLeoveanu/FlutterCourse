import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess the number!',
      theme: ThemeData(primaryColor: Colors.pinkAccent),
      home: const MyHomePage(title: 'Guess the number'),
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
  int realNumber;
  double guessedNumber;
  TextEditingController fieldController = TextEditingController();
  double fontSize = 19;
  String baseMessage = 'Guess the number I am thinking about';
  String displayMessage = 'Try a number';
  String errorMessage;
  bool showInputField = true;

  void startGame() {
    final Random random = Random();
    realNumber = random.nextInt(100);
    displayMessage = 'Try a number';
  }

  void checkNumber() {
    if (realNumber > guessedNumber) {
      displayMessage = 'Try higher.';
    } else if (realNumber < guessedNumber) {
      displayMessage = 'Try lower.';
    } else {
      _showDialog();
      displayMessage = 'You guessed the number!';
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text('You guessed the number!'),
          content: const Text('Do you want to guess again?'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  startGame();
                });
              },
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    showInputField = false;
                  });
                },
                child: const Text('No'))
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startGame();
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
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text(
                    baseMessage,
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          displayMessage,
                          style: const TextStyle(fontSize: 20),
                        ),
                        if (showInputField)
                          Container(
                            padding: const EdgeInsets.all(40),
                            child: TextField(
                              controller: fieldController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Enter your guess',
                                  errorText: errorMessage),
                              onChanged: (String number) {
                                setState(() {
                                  if (double.tryParse(number) == null &&
                                      number.isNotEmpty) {
                                    errorMessage = 'Enter digits only';
                                  } else {
                                    errorMessage = null;
                                    guessedNumber = double.parse(number);
                                    print(realNumber);
                                  }
                                });
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
              if(showInputField)
              RaisedButton(
                elevation: 10,
                onPressed: () {
                  fieldController.clear();
                  setState(() {
                    checkNumber();
                  });
                },
                child: const Text('TRY'),
              ),
              if (!showInputField)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                child: Column(
                  children: <Widget>[
                      RaisedButton(
                          child: const Text('Play again'),
                          onPressed: () {
                            setState(() {
                              startGame();
                              showInputField = true;
                            });
                          }),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
