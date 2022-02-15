import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    useEffect(() {
      ref.read(profileCubitPod)
        ..watchProfile()
        ..refreshProfile();
      return;
    }, []);
    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(profileCubitPod).refreshProfile(),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: BlocConsumer<ProfileCubit, ProfileState>(
                    bloc: ref.watch(profileCubitPod),
                    listener: _profileStateListener,
                    builder: (context, profileState) => ProfilePreview(
                      profile: profileState.profile,
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
