import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../bloc/search/search.dart';
import '../bloc/bookmark/bookmark.dart';
import '../widgets/movie_card_widget.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppTheme.secondaryTextColor),
          ),
          style: theme.textTheme.bodyLarge,
          onChanged: (query) {
            context.read<SearchBloc>().add(SearchQueryChanged(query));
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<SearchBloc>().add(const SearchQueryChanged(''));
              },
            ),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Icon(
                    Icons.search,
                    size: 80,
                    color: AppTheme.secondaryIconColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Search for movies',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is SearchLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            );
          }

          if (state is SearchError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
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

          if (state is SearchEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.movie_filter,
                    size: 80,
                    color: AppTheme.secondaryIconColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No movies found',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is SearchLoaded) {
            return BlocBuilder<BookmarkBloc, BookmarkState>(
              builder: (context, bookmarkState) {
                final bookmarkedIds = bookmarkState is BookmarkLoaded
                    ? bookmarkState.bookmarkedIds
                    : <int>{};

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
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
                      isBookmarked: bookmarkedIds.contains(movie.id),
                      onBookmarkTap: () {
                        context
                            .read<BookmarkBloc>()
                            .add(ToggleBookmarkEvent(movie.id));
                      },
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
