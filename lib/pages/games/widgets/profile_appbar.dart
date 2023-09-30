import 'package:flutter/material.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key, required this.profile});
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              child: Image(image: NetworkImage(profile.avatarUrl)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(profile.username,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(150);
}
