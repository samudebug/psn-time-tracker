import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:games_repository/games_repository.dart';
import 'package:shimmer/shimmer.dart';


class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.game});
  final Game game;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
       decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(5))),
        child: Card(
          child: SizedBox(
            height: 250,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: NetworkImage(game.imageUrl),
                    )),
                  ),
                ),
                Align(alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black, Colors.transparent])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(child: Text(game.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white), overflow: TextOverflow.ellipsis,)),
                    Expanded(child: Text(game.playTime, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white), overflow: TextOverflow.ellipsis, textAlign: TextAlign.end,), )
                  ]),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameCardLoading extends StatelessWidget {
  const GameCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(5))), height: 250, width: 250,);
  }
}