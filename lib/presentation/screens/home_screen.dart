import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../bloc/home/home.dart';
import '../bloc/bookmark/bookmark.dart';
import '../widgets/movie_card_widget.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadMovies());
    context.read<BookmarkBloc>().add(LoadBookmarks());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(RefreshMovies());
          await Future.delayed(const Duration(seconds: 1));
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              );
            }

            if (state is HomeError) {
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
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<HomeBloc>().add(RefreshMovies()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeLoaded) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      context,
                      'Trending Now',
                      state.trendingMovies,
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      context,
                      'Now Playing',
                      state.nowPlayingMovies,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
  
  Widget _buildSection(BuildContext context, String title, List movies) {
    final theme = Theme.of(context);

    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: theme.textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (context, bookmarkState) {
              final bookmarkedIds = bookmarkState is BookmarkLoaded
                  ? bookmarkState.bookmarkedIds
                  : <int>{};

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
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
          ),
        ),
      ],
    );
  }
}
