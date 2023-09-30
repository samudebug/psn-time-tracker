import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:trophies_repository/trophies_repository.dart';

class TrophyInfo extends StatelessWidget {
  TrophyInfo({super.key, required this.trophies}) {
    bronzeTrophies = trophies.where((element) => element.type == 'bronze').toList().length;
    silverTrophies = trophies.where((element) => element.type == 'silver').toList().length;
    goldTrophies = trophies.where((element) => element.type == 'gold').toList().length;
    platinumTrophies = trophies.where((element) => element.type == 'platinum').toList().length;
    int earnedTrophies = trophies.where((element) => element.earned).toList().length;
    percent = (earnedTrophies * 100) / trophies.length;
  }
  final List<Trophy> trophies;
  late int bronzeTrophies;
  late int silverTrophies;
  late int goldTrophies;
  late int platinumTrophies;
  late double percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Bronze: $bronzeTrophies",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Prata: $silverTrophies",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Ouro: $goldTrophies",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Platina: $platinumTrophies",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white)),
              )
            ],
          ),
          CircularPercentIndicator(
            radius: 50,
            lineWidth: 8,
            percent:  percent / 100,
            progressColor: Colors.blue,
            center: Text(
              "${percent.toStringAsFixed(0)}%",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
