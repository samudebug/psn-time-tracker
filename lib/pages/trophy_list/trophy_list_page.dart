import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_repository/games_repository.dart';
import 'package:psn_time_tracker/blocs/trophies_bloc/trophies_bloc.dart';
import 'package:psn_time_tracker/pages/games/widgets/game_card.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/game_title.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/group_title.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_group_list.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_info.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_list.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_list_page_appbar.dart';
import 'package:trophies_repository/trophies_repository.dart';

class TrophyListPage extends StatelessWidget {
  TrophyListPage({super.key, required this.game, required this.group});
  final Game game;
  final TrophyGroup group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrophiesBloc(trophiesRepository: context.read<TrophiesRepository>(), authRepository: context.read<AuthRepository>()),
      child: SafeArea(
          child: Scaffold(
        appBar: TrophyListPageAppBar(),
        body: OrientationBuilder(builder: (context, orientation) => orientation == Orientation.portrait ? _buildPortrait() : _buildLandscape(),),
      )),
    );
  }

  Row _buildLandscape() {
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GroupTitle(group: group),
              BlocBuilder<TrophiesBloc, TrophiesState>(builder: (context, state) {
                if (state is TrophiesInitial) {
                  context.read<TrophiesBloc>().add(LoadTrophies(game.titleId, group.groupId));
                }
                if (state is TrophiesReady) {
                  return TrophyInfo(trophies: state.trophies);
                }
                return Container();
              },),
            ],
          ),
        ),
      ),
       BlocBuilder<TrophiesBloc, TrophiesState>(builder: ((context, state) {
            if (state is TrophiesReady) {
              return Expanded(child: TrophyList(trophies: state.trophies));
            }
            return Expanded(child: Center(child: CircularProgressIndicator(),));
          }))
    ],
    );
  }

  Column _buildPortrait() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GroupTitle(group: group),
          BlocBuilder<TrophiesBloc, TrophiesState>(builder: (context, state) {
            if (state is TrophiesInitial) {
              context.read<TrophiesBloc>().add(LoadTrophies(game.titleId, group.groupId));
            }
            if (state is TrophiesReady) {
              return TrophyInfo(trophies: state.trophies);
            }
            return Container();
          },),
          // Expanded(child: TrophyList(trophies: trophies))
          BlocBuilder<TrophiesBloc, TrophiesState>(builder: ((context, state) {
            if (state is TrophiesReady) {
              return Expanded(child: TrophyList(trophies: state.trophies));
            }
            return Center(child: CircularProgressIndicator(),);
          }))
        ],
      );
  }
}
