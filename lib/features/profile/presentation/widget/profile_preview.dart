import 'package:flutter/material.dart';
import 'package:flutter_my_starred_repos/widgets/safe_network_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile/profile.dart';

class ProfilePreview extends HookConsumerWidget {
  const ProfilePreview({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) => CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: SafeNetworkImage(url: profile.avatarUrl),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profile.name ?? profile.username,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  if (profile.name != null)
                    Text(
                      profile.username,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                ],
              ),
            ),
          ),
        ],
      );
}
