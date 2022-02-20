import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
        final repos = ref.read(starredReposNotifierPod).repos;
        if (repos.isNotEmpty) return;
        WidgetsBinding.instance?.addPostFrameCallback(
          (_) => ref.read(starredReposNotifierPod.notifier).reload(),
        );
        return;
      },
      [],
    );

    ref.listen<StarredReposState>(
      starredReposNotifierPod,
      (_, starredReposState) => starredReposState.whenOrNull(
        loaded: (_, __, warning) => warning?.when(
          offline: () => ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'No reliable Internet connection. Showing cached data.',
                ),
              ),
            ),
        ),
      ),
    );

    final starredReposState = ref.watch(starredReposNotifierPod);
    final starredRepos = starredReposState.repos;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starred Repositories'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(starredReposNotifierPod.notifier).reload(),
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
                itemCount: starredRepos.length + 1,
                itemBuilder: (context, index) {
                  if (index == starredRepos.length) {
                    WidgetsBinding.instance?.addPostFrameCallback(
                      (_) => ref.read(starredReposNotifierPod.notifier).load(),
                    );
                    return starredReposState.maybeWhen(
                      loading: (_) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: LinearProgressIndicator(minHeight: 10.0),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    );
                  }
                  final starredRepo = starredRepos[index];
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
      ),
    );
  }
}
