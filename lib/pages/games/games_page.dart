import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_repository/games_repository.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:psn_time_tracker/blocs/games_bloc/games_bloc.dart';
import 'package:psn_time_tracker/blocs/profile_bloc/profile_bloc.dart';
import 'package:psn_time_tracker/blocs/trophies_bloc/trophies_bloc.dart';
import 'package:psn_time_tracker/blocs/trophy_groups_bloc/trophy_groups_bloc.dart';
import 'package:psn_time_tracker/pages/games/widgets/game_card.dart';
import 'package:psn_time_tracker/pages/games/widgets/profile_appbar.dart';
import 'package:psn_time_tracker/pages/trophy_list/trophy_group_list_page.dart';
import 'package:psn_time_tracker/pages/trophy_list/trophy_list_page.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_group_list.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trophies_repository/trophies_repository.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfile());
    context.read<GamesBloc>().add(LoadGames());
    return SafeArea(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileReady) {
            return Scaffold(
                appBar: ProfileAppBar(profile: state.profile),
                body: BlocBuilder<GamesBloc, GamesState>(
                  builder: (context, gamesState) {
                    if (gamesState is GamesReady) {
                      return ListView.builder(
                          itemCount: gamesState.games.length,
                          itemBuilder: ((context, index) {
                            final Game game = gamesState.games[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (routeContext) =>
                                        RepositoryProvider(
                                          create: (_) => context
                                              .read<TrophiesRepository>(),
                                          child: MultiBlocProvider(
                                            providers: [BlocProvider(create: (_) => TrophyGroupsBloc(
                                                trophiesRepository:
                                                    context.read<
                                                        TrophiesRepository>())),
                                                        BlocProvider(create: (_) => TrophiesBloc(trophiesRepository: context.read<
                                                        TrophiesRepository>()))],
                                            child:
                                                TrophyGroupListPage(game: game),
                                          ),
                                        )));
                              },
                              child: GameCard(game: game),
                            );
                          }));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ));
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
