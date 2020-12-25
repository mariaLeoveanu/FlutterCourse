import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/redux_movie_list/actions/actions.dart';
import 'package:project1/redux_movie_list/model/model.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class GenreContainer extends StatelessWidget {
  const GenreContainer(this.store);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GenreModel>(
      converter: (Store<AppState> store) => GenreModel.fromStore(store),
      builder: (BuildContext context, GenreModel model) {
        return Wrap(
          children: List<Widget>.generate(model.genresList.length, (int index) {
            return ChoiceChip(
              label: Text(model.genresList[index]),
              selected: model.genresList[index] == store.state.genre,
              onSelected: (bool selected) {
                if (selected) {
                  store.dispatch(UpdateGenre(model.genresList[index]));
                } else {
                  store.dispatch(UpdateGenre('nothing'));
                }

                store.dispatch(GetMoviesAction(store.state.currentPage));
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class GenreModel {
  final List<String> genresList = <String>[
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Film-Noir',
    'History',
    'Horror',
    'Music',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Short-Film',
    'Sport',
    'Superhero',
    'Thriller',
    'War',
    'Western'
  ];

  static GenreModel fromStore(Store<AppState> store) {
    return GenreModel();
  }
}
