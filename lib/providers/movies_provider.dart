import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _apiKey = "89f7f916c698f3f4e0c8325333b404c2";
  String _baseUrl = "api.themoviedb.org";
  String _language = "es-ES";

  MoviesProvider() {
    print("Movies provider inicializado");

    this.getOnNowPlaying();
  }

  getOnNowPlaying() {
    var url = Uri.https(_baseUrl, "3/movie/now_playing",
        {"api_key": _apiKey, "language": _language, "page": "1"});
  }
}
