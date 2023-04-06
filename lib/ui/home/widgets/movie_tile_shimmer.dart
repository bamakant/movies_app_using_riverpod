import 'package:flutter/material.dart';
import 'package:movies_app/common/movie_poster.dart';
import 'package:shimmer/shimmer.dart';

class MovieListTileShimmer extends StatelessWidget {
  const MovieListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black26,
      highlightColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              width: MoviePoster.width,
              height: MoviePoster.height,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 15.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                  Container(
                    width: 150.0,
                    height: 15.0,
                    color: Colors.black,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
