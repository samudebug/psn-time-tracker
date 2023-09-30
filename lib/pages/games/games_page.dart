import 'package:flutter/material.dart';
import 'package:psn_time_tracker/pages/games/widgets/game_card.dart';
import 'package:psn_time_tracker/pages/games/widgets/profile_appbar.dart';
import 'package:psn_time_tracker/pages/trophy_list/trophy_list_page.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: ProfileAppBar(
            profile: Profile(
                name: "crisdebug",
                avatarUrl:
                    "http://static-resource.np.community.playstation.net/avatar/WWS_A/A2002_l.png"),
          ),
          body: SafeArea(
              child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TrophyListPage(game: Game(
                        imageUrl:
                            "https://image.api.playstation.com/vulcan/ap/rnd/202110/2814/4adJ0gjnFRysR59iJSZJFQ1J.png",
                        title:
                            "Grand Theft Auto: San Andreas – The Definitive Edition",
                        playTime: "36 horas 39 minutos"))));
                },
                child: GameCard(
                    game: Game(
                        imageUrl:
                            "https://image.api.playstation.com/vulcan/ap/rnd/202110/2814/4adJ0gjnFRysR59iJSZJFQ1J.png",
                        title:
                            "Grand Theft Auto: San Andreas – The Definitive Edition",
                        playTime: "36 horas 39 minutos")),
              ),
              GameCard(
                  game: Game(
                      imageUrl:
                          "https://image.api.playstation.com/vulcan/ap/rnd/202303/0921/500cf443c7a7e8a36a882c393ecb1d4a20b9c04bfef9ad57.png",
                      title: "Sea of Stars",
                      playTime: "2 horas 11 minutos")),
              GameCard(
                  game: Game(
                      imageUrl:
                          "https://image.api.playstation.com/vulcan/ap/rnd/202303/0921/500cf443c7a7e8a36a882c393ecb1d4a20b9c04bfef9ad57.png",
                      title: "Sea of Stars",
                      playTime: "2 horas 11 minutos")),
            ],
          ))),
    );
  }
}
