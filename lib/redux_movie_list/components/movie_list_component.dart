import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/redux_movie_list/model/model.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project1/redux_movie_list/components/details_component.dart';

class MovieListContainer extends StatelessWidget {
  const MovieListContainer(this.store);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MovieListModel>(
      converter: (Store<AppState> store) => MovieListModel.fromStore(store),
      builder: (BuildContext context, MovieListModel model) {
        if (store.state.isLoading) {
          print('i am loading' + store.state.isLoading.toString());
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        } else {
          return GridView.count(
            padding: const EdgeInsets.all(5),
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: List<Widget>.generate(model.movies.length, (int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<SecondRoute>(
                          builder: (BuildContext context) => SecondRoute(movie: model.movies[index])));
                },
                child: Container(
                  decoration: const BoxDecoration(color: Colors.blueAccent),
                  child: Column(
                    children: <Widget>[
                      Expanded(child: Image.network(model.movies[index].coverImageUrl)),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          model.movies[index].title,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        }
      },
    );
  }
}

class MovieListModel {
  MovieListModel(this.movies);

  List<Movie> movies;

  static MovieListModel fromStore(Store<AppState> store) {
    return MovieListModel(store.state.movies);
  }
}
