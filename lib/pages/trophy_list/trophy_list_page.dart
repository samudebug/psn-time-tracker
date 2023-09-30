import 'package:flutter/material.dart';
import 'package:psn_time_tracker/pages/games/widgets/game_card.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/game_title.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_group_llist.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_info.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_list.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_list_page_appbar.dart';

class TrophyListPage extends StatelessWidget {
  TrophyListPage({super.key, required this.game});
  final Game game;
  final List<Trophy> trophies = [
    Trophy(
        earned: false,
        name: "Não sou vacilão",
        description: "Desbloqueie todos os troféus.",
        iconUrl:
            "https://image.api.playstation.com/trophy/np/NPWR23353_00_0097511E77CE88994CF19550A852B90E8F50D9E355/DC17D1D9E6141159A4D7862E1FF539B8AD0167F2.PNG"),
    Trophy(
        name: "Primeiros passos",
        description: "Complete \"Big Smoke\".",
        iconUrl:
            "https://image.api.playstation.com/trophy/np/NPWR23353_00_0097511E77CE88994CF19550A852B90E8F50D9E355/A775E6853ECBAFA6200FA8FE819C9C53E9CAA8A5.PNG",
        earned: true)
  ];

  final List<TrophyGroup> groups = [
    TrophyGroup(name: "Immortals Fenyx Rising™", iconUrl: "https://image.api.playstation.com/trophy/np/NPWR18488_00_00739A980297AFB4D56851B528337DC38724071566/64E271BCEBA6C7590719CDED8C1493689D31DF0F.PNG"),
    TrophyGroup(name: "Um Novo Deus", iconUrl: "https://image.api.playstation.com/trophy/np/NPWR18488_00_00739A980297AFB4D56851B528337DC38724071566/53D6A9765E44A5F304BBF2A0BB427CF6CFC02EFB.PNG")
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: TrophyListPageAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GameTitle(game: game),
          TrophyInfo(),
          // Expanded(child: TrophyList(trophies: trophies))
          Expanded(child: TrophyGroupList(groups: groups),)
        ],
      ),
    ));
  }
}
