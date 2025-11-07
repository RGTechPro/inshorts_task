import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../bloc/bookmark/bookmark.dart';
import '../widgets/movie_card_widget.dart';
import 'movie_detail_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookmarkBloc>().add(LoadBookmarks());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Bookmarks',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            );
          }

          if (state is BookmarkLoaded && state.bookmarkedMovies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bookmark_border,
                    size: 80,
                    color: AppTheme.secondaryIconColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No bookmarked movies yet',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start bookmarking movies to see them here',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.disabledTextColor,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is BookmarkLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.bookmarkedMovies.length,
              itemBuilder: (context, index) {
                final movie = state.bookmarkedMovies[index];
                return MovieCardWidget(
                  movie: movie,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailScreen(movieId: movie.id),
                      ),
                    );
                  },
                  isBookmarked: true,
                  onBookmarkTap: () {
                    context
                        .read<BookmarkBloc>()
                        .add(ToggleBookmarkEvent(movie.id));
                  },
                );
              },
            );
          }

          if (state is BookmarkError) {
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
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
