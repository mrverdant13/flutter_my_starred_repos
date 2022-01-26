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
      ref.read(profileCubitPod).getProfile();
    }, []);
    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => ref.read(profileCubitPod).getProfile(),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: ref.watch(profileCubitPod),
            builder: (context, profileState) => profileState.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (profile) => ProfilePreview(profile: profile),
              failure: (failure) => Center(
                child: Text(
                  failure.when(
                    offline: () => 'Unreliable connection',
                    unexpected: () => 'Unexpected error',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
