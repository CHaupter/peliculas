import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Buscar...";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        padding: EdgeInsets.only(right: 10),
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
      padding: EdgeInsets.only(left: 10),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("BuildResults");
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: _moviesProvider.searchMovies(query),
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return _emptyContainer();
          }

          final List<Movie> movie = snapshot.data!;

          return ListView.builder(
              itemCount: movie.length,
              itemBuilder: (_, int index) => _MovieItem(movie[index]));
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        fit: BoxFit.contain,
        placeholder: AssetImage("assets/loading.gif"),
        image: NetworkImage(movie.fullPosterImage),
        width: 50,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => print(movie.title),
    );
  }
}
