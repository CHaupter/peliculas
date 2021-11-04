import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = "89f7f916c698f3f4e0c8325333b404c2";
  String _baseUrl = "api.themoviedb.org";
  String _language = "es-ES";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print("Movies provider inicializado");

    this.getOnNowPlaying();
    this.getPopularMovies();
  }

  getOnNowPlaying() async {
    var url = Uri.https(_baseUrl, "3/movie/now_playing",
        {"api_key": _apiKey, "language": _language, "page": "1"});

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, "3/movie/popular",
        {"api_key": _apiKey, "language": _language, "page": "1"});

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    popularMovies = [...popularMovies, ...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners();
  }
}
