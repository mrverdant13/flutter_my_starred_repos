import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../core/dependency_injection.dart';
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
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Starred Repositorires'),
          ),
          body: BlocBuilder<StarredReposCubit, StarredReposState>(
            builder: (context, starredReposState) {
              final starredReposCubit = context.read<StarredReposCubit>();
              final starredRepos = starredReposCubit.starredRepos;
              return RefreshIndicator(
                onRefresh: () => starredReposCubit.reload(),
                child: starredRepos.isEmpty()
                    ? LayoutBuilder(
                        builder: (context, constraints) =>
                            SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: constraints.maxHeight,
                            child: const Center(
                              child: Text(
                                  "You haven't starred any repository yet"),
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: starredRepos.size +
                            (starredReposCubit.isLoading ? 1 : 0),
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
                            leading: Image.network(starredRepo.owner.avatarUrl),
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
        ),
      );
}
