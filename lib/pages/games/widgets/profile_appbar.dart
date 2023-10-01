import 'package:flutter/material.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:shimmer/shimmer.dart';

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

class ProfileAppBarLoading extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileAppBarLoading({super.key});

  @override
  Size get preferredSize => Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Shimmer.fromColors(
            enabled: true,
              child: CircleAvatar(
                child: Container(),
              ),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100),
        ),
        Padding(
            padding: EdgeInsets.all(8),
            child: Container(height: 12, width: 70, color: Colors.white,),
          )
      ]),
    );
  }
}
