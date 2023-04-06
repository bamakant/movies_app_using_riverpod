import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/ui/home/viewmodel/movies_list_view_model.dart';
import 'package:movies_app/ui/home/widgets/movie_tile.dart';
import 'package:movies_app/ui/home/widgets/movie_tile_shimmer.dart';

class MoviesListScreen extends ConsumerWidget {
  final String category;
  static const pageSize = 20;

  const MoviesListScreen(this.category, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _appBar(category),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar(String category) {
    String formattedCategory =
        "${category[0].toUpperCase()}${category.substring(1).toLowerCase()}";
    return AppBar(title: Text('$formattedCategory Movies'));
  }

  Widget _body() {
    return Consumer(builder: (context, ref, child) {
      final moviesList = ref.watch(moviesProvider);
      return ListView.custom(
        key: const Key('moviesListKey'),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            return moviesList.when(
              error: (err, stack) =>
                  Center(child: Text('Something went wrong /n$err')),
              loading: () => const MovieListTileShimmer(),
              data: (movies) {
                if (movies != null && movies.isNotEmpty) {
                  final indexInPage = movies.length > 1 ? index % pageSize : 0;
                  final movie = movies[indexInPage];
                  return MovieListTile(movie: movie);
                } else {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child:
                          const Center(child: Text('Something went wrong.')));
                }
              },
            );
          },
          childCount: moviesList.value != null && moviesList.value!.isNotEmpty
              ? moviesList.value!.length
              : 1,
        ),
      );
    });
  }
}
