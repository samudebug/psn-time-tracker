import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_repository/games_repository.dart';
import 'package:psn_time_tracker/blocs/trophies_bloc/trophies_bloc.dart';
import 'package:psn_time_tracker/blocs/trophy_groups_bloc/trophy_groups_bloc.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/game_title.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_group_list.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_info.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_list.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_list_page_appbar.dart';
import 'package:trophies_repository/trophies_repository.dart';

class TrophyGroupListPage extends StatelessWidget {
  const TrophyGroupListPage({super.key, required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    context
        .read<TrophyGroupsBloc>()
        .add(LoadTrophyGroups(titleId: game.titleId));

    return SafeArea(
        child: Scaffold(
      appBar: TrophyListPageAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GameTitle(game: game),
          BlocBuilder<TrophiesBloc, TrophiesState>(
            builder: (context, state) {
            if (state is TrophiesReady) {
              return TrophyInfo(trophies: state.trophies);
            }
            return Container();
          },),
          // Expanded(child: TrophyList(trophies: trophies))
          BlocBuilder<TrophyGroupsBloc, TrophyGroupsStates>(
              builder: (context, state) {
            if (state is TrophyGroupsReady) {
              if (state.trophyGroups.length == 1) {
                context.read<TrophiesBloc>().add(LoadTrophies(game.titleId, state.trophyGroups[0].groupId));
                return BlocBuilder<TrophiesBloc, TrophiesState>(builder: (context, trophiesState) {
                  if (trophiesState is TrophiesReady) {
                    return Expanded(child: TrophyList(trophies: trophiesState.trophies));
                  }
                  return Center(
              child: CircularProgressIndicator(),
            );
                });
              }
              return Expanded(
                child: TrophyGroupList(groups: state.trophyGroups, game: game,),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          })
        ],
      ),
    ));
  }
}
