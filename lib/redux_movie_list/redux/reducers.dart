import 'package:redux/redux.dart';
import 'package:project1/redux_movie_list/model/model.dart';
import 'package:project1/redux_movie_list/actions/actions.dart';

AppState Function(AppState, dynamic) appReducer = combineReducers<AppState>(<AppState Function(AppState, dynamic)>[
  TypedReducer<AppState, GetMoviesAction>(getMoviesReducer),
  TypedReducer<AppState, ReceiveMoviesSuccess>(displayMoviesReducer),
  TypedReducer<AppState, ReceiveMovieError>(displayErrorReducer),
  TypedReducer<AppState, UpdateQuality>(updateQualityReducer),
  TypedReducer<AppState, UpdateGenre>(updateGenreReducer),
  TypedReducer<AppState, UpdateSortType>(updateSortTypeReducer),
  TypedReducer<AppState, ReceiveEmptyList>(updateEmptyListReducer)
]);

AppState getMoviesReducer(AppState appState, GetMoviesAction action) {
  return appState.copyWith(isLoading: appState.movies.isEmpty);
}

AppState displayMoviesReducer(AppState appState, ReceiveMoviesSuccess action) {
  final List<Movie> updatedList = List<Movie>.from(appState.movies);
  updatedList.addAll(action.jsonResponse);
  return appState.copyWith(movies: updatedList, isLoading: false, currentPage: appState.currentPage + 1);
}

AppState displayErrorReducer(AppState appState, ReceiveMovieError action) {
  return appState.copyWith();
}

AppState updateQualityReducer(AppState appState, UpdateQuality action) {
  return appState.copyWith(movies: List<Movie>.empty(), currentPage: 0, quality: action.quality);
}

AppState updateGenreReducer(AppState appState, UpdateGenre action) {
  return appState.copyWith(movies: List<Movie>.empty(), currentPage: 0, genre: action.genre);
}

AppState updateSortTypeReducer(AppState appState, UpdateSortType action) {
  return appState.copyWith(movies: List<Movie>.empty(), currentPage: 0, sortType: action.sortType);
}

AppState updateEmptyListReducer(AppState appState, ReceiveEmptyList action) {
  return appState.copyWith(isLoading: false);
}
