import 'package:flutter/material.dart';
import 'package:trophies_repository/trophies_repository.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key, required this.group});
  final TrophyGroup group;
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
                image: NetworkImage(group.iconUrl),
                height: 80,
              )),
        ),
        Flexible(
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                group.name,
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