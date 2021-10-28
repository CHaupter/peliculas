import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      color: Colors.red,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (_, int index) => _CastCard()),
    );
  }
}

class _CastCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: 110,
      height: 100,
      color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage("assets/loading.gif"),
                image: NetworkImage('https://via.placeholder.com/500x700.png')),
          )
        ],
      ),
    );
  }
}
