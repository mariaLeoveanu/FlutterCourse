import 'package:flutter/material.dart';
import 'package:project1/redux_movie_list/model/model.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    height: constraints.maxHeight / 2,
                    width: constraints.maxWidth / 2 - 8,
                    child: Image.network(movie.coverImageUrl)),
                Expanded(
                  child: Container(
                    height: constraints.maxHeight / 2 - 8,
                    width: constraints.maxWidth / 2 - 8,
                    alignment: Alignment.topRight,
                    child: SingleChildScrollView(
                      child: Card(
                        elevation: 30,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              alignment: Alignment.center,
                              child: const Text(
                                'Movie details',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: RichText(
                                text:
                                    TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                  const TextSpan(text: 'Rating: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: movie.rating.toString(),
                                  )
                                ]),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: RichText(
                                text:
                                    TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                  const TextSpan(text: 'Genres: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: movie.genres.toString().substring(1, movie.genres.toString().length - 1),
                                  )
                                ]),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: RichText(
                                text:
                                    TextSpan(text: '', style: DefaultTextStyle.of(context).style, children: <TextSpan>[
                                  const TextSpan(text: 'Synopsys: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: movie.synopsis,
                                  )
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
