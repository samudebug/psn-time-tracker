import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_repository/games_repository.dart';
import 'package:psn_time_tracker/blocs/trophies_bloc/trophies_bloc.dart';
import 'package:psn_time_tracker/pages/trophy_list/trophy_list_page.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_group_row.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_row.dart';
import 'package:trophies_repository/trophies_repository.dart';

class TrophyGroupList extends StatelessWidget {
  const TrophyGroupList({super.key, required this.groups, required this.game});
  final List<TrophyGroup> groups;
  final Game game;
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
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (routeContext) => TrophyListPage(
                              game: game,
                              group: group,
                            )));
                },
                child: TrophyGroupRow(
                  group: group,
                )),
          );
        });
  }
}
