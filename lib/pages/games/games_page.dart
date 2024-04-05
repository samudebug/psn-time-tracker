import 'dart:io';

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
import 'package:psn_time_tracker/pages/login/login_page.dart';
import 'package:psn_time_tracker/pages/login/login_page_desktop.dart';
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
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailed) {
            context.read<AuthRepository>().clearToken();

            if (Platform.isWindows) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (routeContext) => LoginPageDesktop()));
            } else {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (routeContext) => LoginPage()));
            }
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Scaffold(
                appBar: state is ProfileReady
                    ? ProfileAppBar(profile: (state as ProfileReady).profile)
                    : (const ProfileAppBarLoading() as PreferredSizeWidget),
                body: BlocBuilder<GamesBloc, GamesState>(
                  builder: (context, gamesState) {
                    return OrientationBuilder(
                      builder: (context, orientation) => AnimatedSwitcher(
                        key: const Key("normal"),
                        duration: const Duration(milliseconds: 300),
                        child: gamesState is GamesReady
                            ? GridView.builder(
                                key: const Key("loaded"),
                                itemCount: gamesState.games.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 600.0,
                                        mainAxisSpacing: 16.0,
                                        crossAxisSpacing: 16.0,
                                        mainAxisExtent: 400),
                                itemBuilder: (context, index) {
                                  final Game game = gamesState.games[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (routeContext) =>
                                                  TrophyGroupListPage(
                                                      game: game)));
                                    },
                                    child: GameCard(game: game),
                                  );
                                },
                              )
                            : Shimmer.fromColors(
                                key: const Key("loading"),
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: GridView.builder(
                                    itemCount: 12,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 600.0,
                                        mainAxisSpacing: 16.0,
                                        crossAxisSpacing: 16.0,
                                        mainAxisExtent: 400),
                                    itemBuilder: ((context, index) => Container(
                                          width: double.infinity,
                                          height: 250.0,
                                          margin: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            color: Colors.white,
                                          ),
                                        ))),
                                
                              ),
                      ),
                    );
                  },
                ));
          },
        ),
      ),
    );
  }
}
