import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/movie_entity.dart';
import '../../core/constants/api_constants.dart';
import '../../core/theme/app_theme.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback onTap;
  final bool showBookmarkButton;
  final bool isBookmarked;
  final VoidCallback? onBookmarkTap;

  const MovieCardWidget({
    super.key,
    required this.movie,
    required this.onTap,
    this.showBookmarkButton = false,
    this.isBookmarked = false,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: ApiConstants.getPosterUrl(movie.posterPath),
                    height: 200,
                    width: 140,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      width: 140,
                      color: AppTheme.shimmerBaseColor,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      width: 140,
                      color: AppTheme.shimmerBaseColor,
                      child: Icon(
                        Icons.movie,
                        size: 50,
                        color: AppTheme.secondaryIconColor,
                      ),
                    ),
                  ),
                ),
                if (showBookmarkButton)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onBookmarkTap,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppTheme.overlayColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked
                              ? AppTheme.starColor
                              : AppTheme.primaryIconColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.overlayColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppTheme.starColor,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.primaryTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            if (movie.releaseDate != null && movie.releaseDate!.isNotEmpty)
              Text(
                movie.releaseDate!.split('-')[0],
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.secondaryTextColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
