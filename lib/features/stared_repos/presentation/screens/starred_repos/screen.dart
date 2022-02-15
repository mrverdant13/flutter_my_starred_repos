import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/core/dependency_injection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:starred_repos/starred_repos.dart';

class StarredReposScreen extends HookConsumerWidget {
  const StarredReposScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        ref.read(starredReposCubitPod).load();
        return;
      },
      [],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starred Repositorires'),
      ),
      body: BlocConsumer<StarredReposCubit, StarredReposState>(
        bloc: ref.watch(starredReposCubitPod),
        listener: (context, starredReposState) => starredReposState.whenOrNull(
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
        ),
        builder: (context, starredReposState) {
          final starredRepos = starredReposState.repos;
          final starredReposCubit = ref.read(starredReposCubitPod);
          return RefreshIndicator(
            onRefresh: () => starredReposCubit.reload(),
            child: starredRepos.isEmpty
                ? LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
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
                    itemCount: starredRepos.length +
                        starredReposState.maybeWhen(
                          loading: (_) => 1,
                          orElse: () => 0,
                        ),
                    itemBuilder: (context, index) {
                      if (index == starredRepos.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: LinearProgressIndicator(minHeight: 10.0),
                        );
                      }
                      final starredRepo = starredRepos[index];
                      if (starredRepo == starredRepos.last) {
                        starredReposCubit.load();
                      }
                      return ListTile(
                        key: ValueKey(starredRepo.urlPath),
                        leading: AspectRatio(
                          aspectRatio: 1,
                          child: CachedNetworkImage(
                            imageUrl: starredRepo.owner.avatarUrl,
                            placeholder: (context, url) => const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Center(
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
  }
}
