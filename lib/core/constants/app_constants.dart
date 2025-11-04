class AppConstants {
  // Deep Link
  static const String deepLinkScheme = 'moviesapp';
  static const String deepLinkHost = 'movie';

  // Database
  static const String databaseName = 'movies_database.db';
  static const int databaseVersion = 1;

  // Tables
  static const String moviesTable = 'movies';
  static const String bookmarksTable = 'bookmarks';

  // Search Debounce
  static const int searchDebounceMilliseconds = 500;
}
