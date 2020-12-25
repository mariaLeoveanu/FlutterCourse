import 'package:project1/redux_movie_list/model/model.dart';

class GetMoviesAction {
  GetMoviesAction(this.page);

  int page;
}

class ReceiveMoviesSuccess {
  ReceiveMoviesSuccess(this.jsonResponse);

  List<Movie> jsonResponse;
}

class ReceiveMovieError {}

class UpdateQuality {
  UpdateQuality(this.quality);

  String quality;
}

class UpdateGenre {
  UpdateGenre(this.genre);

  String genre;
}

class UpdateSortType {
  UpdateSortType(this.sortType);

  String sortType;
}

class ReceiveEmptyList {
  ReceiveEmptyList();
}
