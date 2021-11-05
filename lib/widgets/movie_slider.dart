import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {Key? key, required this.movies, this.title, required this.onNextPage})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        print("Siguiente página");

        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: 260,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.title == null) {
      return Container(
        width: double.infinity,
        height: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Si no hay titulo, no mostrar este Widget

            Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) {
                      return _MoviePoster(widget.movies[index]);
                    }))
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Si no hay titulo, no mostrar este Widget
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) {
                      return _MoviePoster(widget.movies[index]);
                    }))
          ],
        ),
      );
    }
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, "details", arguments: movie),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage("assets/no-image.jpg"),
                      image: NetworkImage(movie.fullPosterImage)))),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )
        ],
      ),
    );
  }
}
