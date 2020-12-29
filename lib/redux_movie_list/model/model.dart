class Movie {
  Movie(this.title, this.coverImageUrl, this.rating, this.genres, this.synopsis);

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        coverImageUrl = json['large_cover_image'],
        rating = json['rating'],
        genres = json['genres'],
        synopsis = json['synopsis'];

  final String title;
  final String coverImageUrl;
  final num rating;
  final List<dynamic> genres;
  final String synopsis;
}

class AppState {
  AppState({this.movies, this.currentPage, this.quality, this.isLoading, this.genre, this.sortType});

  static AppState initialState() {
    return AppState(
        movies: List<Movie>.unmodifiable(<Movie>[]),
        currentPage: 0,
        isLoading: false,
        quality: 'All',
        genre: 'nothing',
        sortType: 'desc');
  }

  AppState copyWith(
      {List<Movie> movies, int currentPage, String quality, bool isLoading, String genre, String sortType}) {
    return AppState(
        movies: movies ?? this.movies,
        currentPage: currentPage ?? this.currentPage,
        quality: quality ?? this.quality,
        isLoading: isLoading ?? this.isLoading,
        genre: genre ?? this.genre,
        sortType: sortType ?? this.sortType);
  }

  final List<Movie> movies;
  int currentPage;
  String quality;
  bool isLoading;
  String genre;

  // sort by rating
  String sortType;
}
