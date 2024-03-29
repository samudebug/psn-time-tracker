import 'package:auth_repository/auth_repository.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TrophyGroupsBloc(
                trophiesRepository: context.read<TrophiesRepository>(),
                authRepository: context.read<AuthRepository>())),
        BlocProvider(
            create: (context) => TrophiesBloc(
                trophiesRepository: context.read<TrophiesRepository>(),
                authRepository: context.read<AuthRepository>()))
      ],
      child: SafeArea(
          child: Scaffold(
        appBar: TrophyListPageAppBar(),
        body: OrientationBuilder(
          builder: (context, orientation) => orientation == Orientation.portrait
              ? _buildPortrait()
              : _buildLandscape(),
        ),
      )),
    );
  }

  Row _buildLandscape() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GameTitle(game: game),
                BlocBuilder<TrophiesBloc, TrophiesState>(
                  builder: (context, state) {
                    if (state is TrophiesReady) {
                      return TrophyInfo(trophies: state.trophies);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<TrophyGroupsBloc, TrophyGroupsStates>(
            builder: (context, state) {
          if (state is TrophyGroupsInitial) {
            context
                .read<TrophyGroupsBloc>()
                .add(LoadTrophyGroups(titleId: game.titleId));
          }
          if (state is TrophyGroupsReady) {
            if (state.trophyGroups.length == 1) {
              context.read<TrophiesBloc>().add(
                  LoadTrophies(game.titleId, state.trophyGroups[0].groupId));
              return BlocBuilder<TrophiesBloc, TrophiesState>(
                  builder: (context, trophiesState) {
                if (trophiesState is TrophiesReady) {
                  return Expanded(
                      child: trophiesState.trophies.isEmpty ? Center(child: Text("Nenhum dado para mostrar", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),) : TrophyList(trophies: trophiesState.trophies));
                }
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              });
            }
            context.read<TrophiesBloc>().emit(TrophiesInitial());
            return Expanded(
              child: state.trophyGroups.isEmpty ? Center(child: Text("Nenhum dado para mostrar", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),) : TrophyGroupList(
                groups: state.trophyGroups,
                game: game,
              )
            );
          }
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        })
      ],
    );
  }

  Column _buildPortrait() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GameTitle(game: game),
        BlocBuilder<TrophiesBloc, TrophiesState>(
          builder: (context, state) {
            if (state is TrophiesReady) {
              return TrophyInfo(trophies: state.trophies);
            }
            return Container();
          },
        ),
        // Expanded(child: TrophyList(trophies: trophies))
        BlocBuilder<TrophyGroupsBloc, TrophyGroupsStates>(
            builder: (context, state) {
          if (state is TrophyGroupsInitial) {
            context
                .read<TrophyGroupsBloc>()
                .add(LoadTrophyGroups(titleId: game.titleId));
          }
          if (state is TrophyGroupsReady) {
            if (state.trophyGroups.length == 1) {
              context.read<TrophiesBloc>().add(
                  LoadTrophies(game.titleId, state.trophyGroups[0].groupId));
              return BlocBuilder<TrophiesBloc, TrophiesState>(
                  builder: (context, trophiesState) {
                if (trophiesState is TrophiesReady) {
                  return Expanded(
                      child: TrophyList(trophies: trophiesState.trophies));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
            }
            context.read<TrophiesBloc>().emit(TrophiesInitial());
            return Expanded(
              child: TrophyGroupList(
                groups: state.trophyGroups,
                game: game,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        })
      ],
    );
  }
}
