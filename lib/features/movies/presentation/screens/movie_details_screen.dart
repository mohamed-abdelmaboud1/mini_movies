import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mini_movies/core/constant/api_endpoints.dart';
import 'package:mini_movies/features/movies/data/models/movie_model.dart';
import 'package:mini_movies/features/movies/presentation/widgets/custom_shimmer.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Details',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                width: 250,
                height: 375,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: movie.id,
                    child: CachedNetworkImage(
                      imageUrl: movie.posterPath?.toImageUrl ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CustomShimmer(height: 375, width: 250),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Title and Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const Gap(16),

                  // Rating and Genre Row
                  Row(
                    children: [
                      // Rating
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFC107),
                        size: 24,
                      ),
                      const Gap(6),
                      Text(
                        '${movie.voteAverage} / 10',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const Gap(16),

                      // Genre Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          movie.releaseDate ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),

                  // Description Section
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const Gap(12),

                  // Description Text
                  Text(
                    movie.overview,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      height: 1.6,
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
