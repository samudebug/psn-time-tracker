import 'package:flutter/material.dart';
import 'package:psn_time_tracker/pages/trophy_list/widgets/trophy_list.dart';
import 'package:trophies_repository/trophies_repository.dart';

class TrophyRow extends StatelessWidget {
  const TrophyRow({super.key, required this.trophy});
  final Trophy trophy;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        image: NetworkImage(trophy.iconUrl),
        height: 40,
      ),
      title: Text(
        trophy.name,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
      subtitle: Text(trophy.description,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white70),),
              trailing: SizedBox(height: 40, width: 40, child: trophy.earned ? Icon(Icons.check, color: Colors.white) : Container(),),
    );
    // return Row(
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.all(8),
    //       child: Image(
    //         image: NetworkImage(trophy.iconUrl),
    //         height: 40,
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.all(8),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             trophy.name,
    //             style: Theme.of(context)
    //                 .textTheme
    //                 .titleMedium
    //                 ?.copyWith(color: Colors.white),
    //           ),
    //           Text(trophy.description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70))
    //         ],
    //       ),
    //     ),
    //     Spacer(),
    //     if (trophy.earned) Padding(padding: EdgeInsets.all(8), child: Icon(Icons.check, color: Colors.white,),)
    //   ],
    // );
  }
}
