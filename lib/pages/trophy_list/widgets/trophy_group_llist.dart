import 'package:flutter/material.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_group_row.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_row.dart';

class TrophyGroup {
  String name;
  String iconUrl;

  TrophyGroup({required this.name, required this.iconUrl});
}

class TrophyGroupList extends StatelessWidget {
  const TrophyGroupList({super.key, required this.groups});
  final List<TrophyGroup> groups;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: groups.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          TrophyGroup group = groups[index];
          return Padding(
            padding: EdgeInsets.all(8),
            child: TrophyGroupRow(group: group,),
          );
        });
  }
}
