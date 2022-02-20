import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_my_starred_repos/features/profile/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/profile/presentation/widget/profile_preview.dart';
import 'package:flutter_my_starred_repos/presentation/widgets/drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile/profile.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ProfileState>(
      profileNotifierPod,
      (_, profileState) => _profileStateListener(context, profileState),
    );
    useEffect(
      () {
        WidgetsBinding.instance?.addPostFrameCallback(
          (_) => ref.read<ProfileNotifier>(profileNotifierPod.notifier)
            ..watchProfile()
            ..refreshProfile(),
        );
        return;
      },
      [],
    );
    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(profileNotifierPod.notifier).refreshProfile(),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ProfilePreview(
                    profile: ref.watch<Profile>(
                      profileNotifierPod.select(
                        (s) => s.profile,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _profileStateListener(
    BuildContext context,
    ProfileState profileState,
  ) =>
      profileState.whenOrNull(
        failure: (_, failure) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              failure.when(
                offline: () => 'Unreliable network',
                unexpected: () => 'Unexpected error',
              ),
            ),
          ),
        ),
      );
}
