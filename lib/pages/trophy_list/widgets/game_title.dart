import 'package:flutter/material.dart';
import 'package:psn_time_tracker/pages/games/widgets/game_card.dart';

class GameTitle extends StatelessWidget {
  const GameTitle({super.key, required this.game});
  final Game game;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: NetworkImage(game.imageUrl),
                height: 80,
              )),
        ),
        Flexible(
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                game.title,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              )),
        )
      ]),
    );
  }
}
