import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  // Get API key from environment variables
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String posterSize = 'w500';
  static const String backdropSize = 'w780';
  static const String originalSize = 'original';

  static String getPosterUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$imageBaseUrl/$posterSize$path';
  }

  static String getBackdropUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$imageBaseUrl/$backdropSize$path';
  }

  static String getOriginalUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$imageBaseUrl/$originalSize$path';
  }
}
