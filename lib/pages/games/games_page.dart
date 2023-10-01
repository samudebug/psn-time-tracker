import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trophies_repository/trophies_repository.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfile());
    context.read<GamesBloc>().add(LoadGames());
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[850]));
    return SafeArea(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
              appBar: state is ProfileReady
                  ? ProfileAppBar(profile: (state as ProfileReady).profile)
                  : (ProfileAppBarLoading() as PreferredSizeWidget),
              body: BlocBuilder<GamesBloc, GamesState>(
                builder: (context, gamesState) {
                  return AnimatedSwitcher(key: Key("normal"), duration: Duration(milliseconds: 300), child: gamesState is GamesReady ? AnimatedList(
                        initialItemCount: gamesState.games.length,
                        itemBuilder: ((context, index, animation) {
                          final Game game = gamesState.games[index];
                          return FadeTransition(opacity: animation, child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (routeContext) =>
                                      TrophyGroupListPage(game: game)));
                            },
                            child: GameCard(game: game),
                          ),);
                        })) : Shimmer.fromColors(
                          key: Key("loading"),
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: ((context, index) => Container(
                                width: double.infinity,
                                height: 250.0,
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                ),
                              ))),
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                    ),);
                },
              ));
        },
      ),
    );
  }
}
