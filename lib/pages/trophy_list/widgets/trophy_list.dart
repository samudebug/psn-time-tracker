import 'package:flutter/material.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_row.dart';
import 'package:trophies_repository/trophies_repository.dart';

class TrophyList extends StatelessWidget {
  const TrophyList({super.key, required this.trophies});
  final List<Trophy> trophies;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: trophies.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          Trophy trophy = trophies[index];
          return Padding(
            padding: EdgeInsets.all(8),
            child: TrophyRow(trophy: trophy),
          );
        });
  }
}
