import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_theme.dart';
import '../bloc/movie_detail/movie_detail.dart';
import '../bloc/bookmark/bookmark.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/app_constants.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(LoadMovieDetail(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            );
          }

          if (state is MovieDetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.errorColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          if (state is MovieDetailLoaded) {
            final movie = state.movieDetail;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              ApiConstants.getBackdropUrl(movie.backdropPath),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppTheme.shimmerBaseColor,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppTheme.shimmerBaseColor,
                            child: const Icon(Icons.movie, size: 100),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppTheme.backgroundColor.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    BlocBuilder<BookmarkBloc, BookmarkState>(
                      builder: (context, bookmarkState) {
                        final isBookmarked = bookmarkState is BookmarkLoaded &&
                            bookmarkState.bookmarkedIds
                                .contains(widget.movieId);
                        return IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: isBookmarked
                                ? AppTheme.starColor
                                : AppTheme.primaryIconColor,
                          ),
                          onPressed: () {
                            context
                                .read<BookmarkBloc>()
                                .add(ToggleBookmarkEvent(widget.movieId));
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        _shareMovie(movie.id, movie.title);
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildInfoChip(
                              Icons.star,
                              '${movie.voteAverage.toStringAsFixed(1)}/10',
                              AppTheme.starColor,
                            ),
                            if (movie.releaseDate != null)
                              _buildInfoChip(
                                Icons.calendar_today,
                                movie.releaseDate!,
                                AppTheme.infoColor,
                              ),
                            if (movie.runtime > 0)
                              _buildInfoChip(
                                Icons.access_time,
                                '${movie.runtime} min',
                                AppTheme.successColor,
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (movie.genres.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: movie.genres.map((genre) {
                              return Chip(
                                label: Text(genre.name),
                                backgroundColor: AppTheme.cardColor,
                              );
                            }).toList(),
                          ),
                        const SizedBox(height: 24),
                        Text(
                          'Overview',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.overview,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildInfoRow('Status', movie.status),
                        _buildInfoRow('Original Language',
                            movie.originalLanguage.toUpperCase()),
                        _buildInfoRow(
                            'Budget',
                            movie.budget > 0
                                ? '\$${_formatNumber(movie.budget)}'
                                : 'N/A'),
                        _buildInfoRow(
                            'Revenue',
                            movie.revenue > 0
                                ? '\$${_formatNumber(movie.revenue)}'
                                : 'N/A'),
                        const SizedBox(height: 24),
                        if (movie.productionCompanies.isNotEmpty) ...[
                          Text(
                            'Production Companies',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: movie.productionCompanies.map((company) {
                              return Chip(
                                label: Text(company.name),
                              );
                            }).toList(),
                          ),
                        ],
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.secondaryTextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  void _shareMovie(int movieId, String title) {
    final deepLink =
        '${AppConstants.deepLinkScheme}://${AppConstants.deepLinkHost}/$movieId';
    Share.share(
      'Check out this movie: $title\n$deepLink',
      subject: 'Movie Recommendation',
    );
  }
}
