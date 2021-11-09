import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';

class CardSwiper extends StatefulWidget {
  final List<Movie> movies;
  final Function onNextPage;

  const CardSwiper({Key? key, required this.movies, required this.onNextPage})
      : super(key: key);

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    @override
    void initState() {
      super.initState();

      _swiperController.addListener(() {
        print(_swiperController.index);
        print(_swiperController.pos);

        if (_swiperController.index == widget.movies.length - 1) {
          widget.onNextPage;
        }
      });
    }

    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
    }

    if (this.widget.movies.length == 0) {
      return Container(
          width: double.infinity,
          height: size.height / 2,
          child: Center(
            child: CircularProgressIndicator(),
          ));
    }

    return Container(
      width: double.infinity,
      height: size.height / 2,
      child: Swiper(
        loop: false,
        controller: _swiperController,
        itemCount: widget.movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (context, int index) {
          final movie = widget.movies[index];

          return GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, "details", arguments: movie),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImage),
                  fit: BoxFit.cover,
                ),
              ));
        },
      ),
    );
  }
}
