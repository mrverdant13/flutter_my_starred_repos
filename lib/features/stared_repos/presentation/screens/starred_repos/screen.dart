import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/core/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/starred_repos_cubit/cubit.dart';

part 'wrapper.dart';

/// {@template StarredReposScreen}
/// A screen that displays a collection of starred repositories.
/// {@endtemplate}
class StarredReposScreen extends StatelessWidget {
  /// Creates a starred repositories screen.
  ///
  /// {@macro StarredReposScreen}
  const StarredReposScreen();

  @override
  Widget build(BuildContext context) => _Wrapper(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Starred Repositorires'),
            ),
            body: BlocConsumer<StarredReposCubit, StarredReposState>(
              listener: (context, starredReposState) => starredReposState.when(
                loaded: (_, __, warning) => warning?.when(
                  offline: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    return ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'No reliable Internet connection. Showing cached data.',
                        ),
                      ),
                    );
                  },
                ),
                loading: (_) {},
              ),
              builder: (context, starredReposState) {
                final starredRepos = starredReposState.repos;
                final starredReposCubit = context.read<StarredReposCubit>();
                return RefreshIndicator(
                  onRefresh: () => starredReposCubit.reload(),
                  child: starredRepos.isEmpty()
                      ? LayoutBuilder(
                          builder: (context, constraints) =>
                              SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: constraints.maxHeight,
                              child: Center(
                                child: starredReposState.maybeWhen(
                                  loading: (_) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 10),
                                      Text('Loading'),
                                    ],
                                  ),
                                  orElse: () => const Text(
                                    "You haven't starred any repository yet",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: starredRepos.size +
                              starredReposState.maybeWhen(
                                loading: (_) => 1,
                                orElse: () => 0,
                              ),
                          itemBuilder: (context, index) {
                            if (index == starredRepos.size) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: LinearProgressIndicator(minHeight: 10.0),
                              );
                            }
                            final starredRepo = starredRepos[index];
                            if (starredRepo == starredRepos.iter.last) {
                              starredReposCubit.load();
                            }
                            return ListTile(
                              key: ValueKey(starredRepo.id),
                              leading: AspectRatio(
                                aspectRatio: 1,
                                child: CachedNetworkImage(
                                  imageUrl: starredRepo.owner.avatarUrl,
                                  placeholder: (context, url) => const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Icon(
                                      Icons.image,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(starredRepo.name),
                              subtitle: Text(starredRepo.owner.username),
                              trailing: AspectRatio(
                                aspectRatio: 1,
                                child: Column(
                                  children: [
                                    const Icon(Icons.star),
                                    Text('${starredRepo.starsCount}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          );
        },
      );
}
