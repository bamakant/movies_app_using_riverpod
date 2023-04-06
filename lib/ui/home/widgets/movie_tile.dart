import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/common/movie_poster.dart';
import 'package:movies_app/common/ratings_widget.dart';
import 'package:movies_app/model/movie_response.dart';

class MovieListTile extends StatelessWidget {
  final Movie movie;

  const MovieListTile({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MoviePoster.width,
                height: MoviePoster.height,
                child: MoviePoster(imagePath: movie.posterPath),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (movie.releaseDate != null &&
                    movie.releaseDate!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(DateFormat.yMMMMd()
                      .format(DateTime.parse(movie.releaseDate!))),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconTheme(
                      data: const IconThemeData(
                        color: Colors.cyanAccent,
                        size: 20,
                      ),
                      child: RatingWidget(
                        value: ((movie.voteAverage! * 5) / 10).round(),
                      ),
                    ),
                    Text(
                      "  ${movie.voteAverage!}/10",
                      style: const TextStyle(
                        color: Colors.amber,
                        letterSpacing: 1.2,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
