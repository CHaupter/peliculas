import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String movie = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(
              [_PosterAndTitle(), _Overview(), _Overview(), CastingCards()]),
        ),
        //SliverFillRemaining(),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.black45,
          width: double.infinity,
          child: Text("movie.title",
              style: TextStyle(fontSize: 16, color: Colors.red)),
        ),
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage("https://via.placeholder.com/400x300"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                fit: BoxFit.cover,
                height: 150,
                placeholder: AssetImage("assets/no-image.jpg"),
                image: NetworkImage("https://via.placeholder.com/200x300")),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "movie.title",
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text("movie.originalTitle",
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
              Row(
                children: [
                  Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5),
                  Text("movie.voteAverage",
                      style: textTheme.caption,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          "Esse minim veniam ex elit cillum. Ipsum enim occaecat excepteur Lorem laborum aute laboris magna. Duis officia excepteur consectetur est velit amet laboris tempor." +
              "Ad velit in occaecat nulla eu cupidatat incididunt id officia incididunt duis id. Sint commodo ipsum dolore et. Amet laborum eiusmod voluptate esse. Excepteur ad incididunt id incididunt ex et cupidatat cillum. Et qui excepteur deserunt consequat duis excepteur dolor. Est occaecat laboris veniam sunt consectetur ullamco occaecat aliquip cillum sunt. Exercitation dolor qui consectetur ut officia incididunt in veniam id magna." +
              "Tempor reprehenderit eiusmod deserunt commodo adipisicing nostrud. Eiusmod voluptate tempor sint proident nulla id magna deserunt duis. Qui ad ad pariatur culpa est ea eiusmod excepteur amet ullamco ex ex tempor ullamco. Nulla aliquip exercitation ullamco enim.",
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.justify,
        ));
  }
}
