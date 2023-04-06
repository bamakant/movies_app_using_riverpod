import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/service/api_urls.dart';
import 'package:shimmer/shimmer.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, this.imagePath});

  final String? imagePath;

  static const width = 150.0;
  static const height = 230.0;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: '${ApiUrls.basePosterURI}/$imagePath',
          placeholder: (_, __) => Shimmer.fromColors(
            baseColor: Colors.black26,
            highlightColor: Colors.black12,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black54
              ),
              width: width,
              height: height,
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade900,
        boxShadow: kElevationToShadow[8],
      ),
    );
  }
}
