import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TrophyInfo extends StatelessWidget {
  const TrophyInfo({super.key});

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
                child: Text("Bronze: 24",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Prata: 24",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Ouro: 24",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Platina: 1",
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
            percent: 0.7,
            progressColor: Colors.blue,
            center: Text(
              "70%",
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
