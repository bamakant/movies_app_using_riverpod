import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/model/movie_response.dart';
import 'package:movies_app/ui/home/repo/movie_repo.dart';
import 'package:movies_app/ui/home/widgets/home_view.dart';

final moviesProvider = FutureProvider<List<Movie>?>((ref) async {
  final category = ref.watch(categoryProvider);
  return await MovieRepo().getMovies(category);
});
