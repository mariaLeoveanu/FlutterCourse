import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Movie {
  Movie(this.title, this.coverImageUrl);

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        coverImageUrl = json['large_cover_image'];

  final String title;
  final String coverImageUrl;

  Movie copyWith({String title, String coverImageUrl}) {
    return Movie(title ?? this.title, coverImageUrl ?? this.coverImageUrl);
  }
}

class AppState {
  AppState({@required this.movies, this.currentPage, this.quality, this.isLoading});

  static AppState initialState() {
    return AppState(movies: List<Movie>.unmodifiable(<Movie>[]),
        currentPage: 0,
        isLoading: false);
  }

  AppState copyWith({List<Movie> movies, int currentPage, String quality, bool isLoading}) {
    return AppState(
        movies: movies ?? this.movies,
        currentPage: currentPage ?? this.currentPage,
        quality: quality ?? this.quality,
        isLoading: isLoading ?? this.isLoading);
  }

  final List<Movie> movies;
  int currentPage;
  String quality;
  bool isLoading;
}
