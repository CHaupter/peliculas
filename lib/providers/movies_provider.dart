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

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    print("Movies provider inicializado");

    this.getOnNowPlaying();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endPoint,
        {"api_key": _apiKey, "language": _language, "page": "$page"});

    final response = await http.get(url);
    return response.body;
  }

  getOnNowPlaying() async {
    final respuesta = await _getJsonData("3/movie/now_playing");
    final nowPlayingResponse = NowPlayingResponse.fromJson(respuesta);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final respuesta = await _getJsonData("3/movie/popular", _popularPage);
    final popularResponse = PopularResponse.fromJson(respuesta);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final respuesta = await _getJsonData("3/movie/$movieId/credits");
    final creditsResponse = CreditsResponse.fromJson(respuesta);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
