import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries',
      theme: ThemeData(primaryColor: Colors.pinkAccent),
      home: const MyHomePage(title: 'Countries'),
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
  List<String> flags;
  List<String> countries;

  Future<void> getData() async {
    final Response response = await get('https://www.worldometers.info/geography/flags-of-the-world/');
    final String data = response.body;
    final List<String> items = data.split('<a href="/img/flags');
    for (final String item in items.skip(1)) {
      const String countryTilePattern = 'padding-top:10px">';
      final String countryName =
          item.substring(item.indexOf(countryTilePattern) + countryTilePattern.length, item.indexOf('</div>'));
      final String flagUrl = 'https://www.worldometers.info/img/flags${item.split('"')[0]}';
      flags.add(flagUrl);
      countries.add(countryName);
    }
  }

  @override
  void initState() {
    super.initState();
    flags = <String>[];
    countries = <String>[];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: AnimatedContainer(
            duration: const Duration(seconds: 1),
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: List<Widget>.generate(countries.length, (int i) {
                  return Container(
                    child: Column(children: <Widget>[const Text('bla'), Expanded(child: Image.network(flags[i]))]),
                  );
                }))));
  }
}
