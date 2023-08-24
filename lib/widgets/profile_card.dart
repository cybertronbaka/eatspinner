import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/models/_all.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:eatspinner/widgets/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProfileCard extends StatelessWidget{
  final Profile? profile;
  const ProfileCard({
    super.key,
    required this.profile
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          ProfilePhoto(
            url: StorageUtils.getPublicUrl(profile?.avatarUrl),
            diameter: 60,
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 5,
            child: SpacedColumn(
              spaceHeight: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  profile?.name ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                Text(
                  profile?.bio != null && profile?.bio! != ''
                    ? (
                      profile!.bio!.trim().length < 30
                          ? profile!.bio!.trim()
                          : '${profile?.bio!.trim().replaceAll('\n', ' ').substring(0, 30)}...'
                    )
                    : '',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF626262)
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: (){
                context.push(Routes.editProfile);
              },
              icon: const Icon(Icons.edit_outlined)
          )
        ],
      ),
    );
  }
}