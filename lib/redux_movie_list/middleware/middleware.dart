import 'dart:convert';
import 'package:http/http.dart';
import 'package:project1/redux_movie_list/model/model.dart';
import 'package:project1/redux_movie_list/actions/actions.dart';

import 'package:redux/redux.dart';

Future<void> appStateMiddleware(Store<AppState> appState, dynamic action, NextDispatcher nextDispatcher) async {
  nextDispatcher(action);
  print(action.runtimeType);

  if (action is GetMoviesAction) {
    final int pageRequested = appState.state.currentPage + 1;
    final String sortType = appState.state.sortType;
    String url = 'https://yts.mx/api/v2/list_movies.json?sort_by=rating&&page=$pageRequested&&order_by=$sortType';

    if (appState.state.quality != 'All') {
      final String quality = appState.state.quality;
      url += '&&quality=$quality';
    }
    if (appState.state.genre != 'nothing') {
      final String genre = appState.state.genre.toLowerCase();
      url += '&&genre=$genre';
    }

    print(url);
    final Response response = await get(url);

    final String message = json.decode(response.body)['status'];
    if (message == 'ok') {
      final List<dynamic> data = json.decode(response.body)['data']['movies'];
      if (data != null && data.isNotEmpty) {
        final List<Movie> movies = data.map((dynamic e) => Movie.fromJson(e)).toList();
        final ReceiveMoviesSuccess actionSuccess = ReceiveMoviesSuccess(movies);
        appState.dispatch(actionSuccess);
      } else {
        final ReceiveEmptyList actionEmpty = ReceiveEmptyList();
        appState.dispatch(actionEmpty);
      }
    } else {
      final ReceiveMovieError errorAction = ReceiveMovieError();
      appState.dispatch(errorAction);
    }
  }
}
