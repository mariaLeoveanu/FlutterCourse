import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Currency Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  double input;
  double convertedValue = 0;
  bool incorrectInput = false;
  String errorMessage = '';

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
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                    'https://media.gettyimages.com/vectors/money-banknotes-and-'
                        'coins-drawing-vector-id499480988?k=6&m=499480988&s='
                        '612x612&w=0&h=9ZxQo_3biW-SuGv0vc8yHJ09E'
                        'yrmwXC8V2EovbDGzQs='),
              )),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text('Enter the value you want to convert'),
            ),
            TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  errorText: errorMessage,
                  hintText: 'LEI'),
              keyboardType: const TextInputType.numberWithOptions(),
              onChanged: (String message) {
                setState(() {
                  if (message == null || double.tryParse(message) == null) {
                    errorMessage = 'Enter only digits';
                  } else {
                    input = double.parse(message);
                    errorMessage = null;
                  }
                });
              },
            ),
            OutlineButton(
              onPressed: () {
                setState(() {
                  convertedValue = 4.5 * input;
                });
              },
              child: const Text('Convert to EUR'),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('The converted value is ' +
                  convertedValue.toString() +
                  ' EUR.'),
            )
          ],
        ),
      ),
    );
  }
}
