import 'dart:convert';

import 'package:http/http.dart' as http;

class Movie {
  // param optional name
  const Movie({this.title, this.year, this.summary, this.genres});

  Movie.fromJson(dynamic movie)
      : title = movie['title'],
        year = movie['year'],
        summary = movie['summary'],
        genres = List<String>.from(movie['genres']);

  final String title;
  final int year;
  final String summary;
  final List<String> genres;

  @override
  String toString() {
    return 'Title: ' +
        title +
        ' year: ' +
        year.toString() +
        '\n' +
        summary +
        genres.toString();
  }
}

Future<void> main() async {
  //http.get('https://yts.mx/api/v2/list_movies.json').then((http.Response response) {
  //  final Map<String, dynamic> map = jsonDecode(response.body);
  //  print(map['data']['movies'][0]['title']);
  //});

  // await - async
  //final http.Response resp =
  //await http.get('https://yts.mx/api/v2/list_movies.json');
  // print(jsonDecode(resp.body)['data']['movies'][0]['title']);

//  final http.Response resp =
//      await http.get('https://yts.mx/api/v2/list_movies.json');
//  List<dynamic> movies = jsonDecode(resp.body)['data']['movies'];
//  for(int i = 0; i < movies.length; i++){
//    print(movies[i]['title']);
//  }

  final http.Response response =
      await http.get('https://yts.mx/api/v2/list_movies.json');
  final Map<String, dynamic> map = jsonDecode(response.body)['data'];
  final List<dynamic> movies = map['movies'];
  final List<Movie> convertedMovies =
      movies.map((dynamic movie) => Movie.fromJson(movie)).toList();
  print(convertedMovies);
}
