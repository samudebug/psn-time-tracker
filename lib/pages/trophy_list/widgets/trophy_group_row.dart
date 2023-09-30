import 'package:flutter/material.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_group_llist.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_list.dart';

class TrophyGroupRow extends StatelessWidget {
  const TrophyGroupRow({super.key, required this.group});
  final TrophyGroup group;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Image(
            image: NetworkImage(group.iconUrl),
            height: 40,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            group.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
