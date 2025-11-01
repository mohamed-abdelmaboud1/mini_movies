import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mini_movies/core/constant/api_endpoints.dart';
import 'package:mini_movies/features/movies/data/models/movie_model.dart';
import 'package:mini_movies/features/movies/presentation/screens/movie_details_screen.dart';
import 'package:mini_movies/features/movies/presentation/widgets/custom_shimmer.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Movie Poster
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Hero(
                tag: movie.id,
                child: CachedNetworkImage(
                  imageUrl: movie.posterPath?.toImageUrl ?? '',
                  width: 120,
                  height: 180,
                  fit: BoxFit.cover,

                  placeholder: (context, url) =>
                      CustomShimmer(height: 180, width: 120),

                  errorWidget: (context, url, error) => Container(
                    width: 120,
                    height: 180,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            // Movie Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(12),

                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFC107),
                          size: 20,
                        ),
                        const Gap(4),
                        Text(
                          '${movie.voteAverage.toInt()}/10',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),

                    // Genre
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        movie.releaseDate ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Arrow Icon
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.chevron_right,
                size: 28,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
