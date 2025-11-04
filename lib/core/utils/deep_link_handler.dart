import 'dart:async';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/material.dart';

class DeepLinkHandler {
  static final DeepLinkHandler instance = DeepLinkHandler._init();
  StreamSubscription? _sub;

  DeepLinkHandler._init();

  void initialize(BuildContext context) {
    _handleIncomingLinks(context);
    _handleInitialUri(context);
  }

  void _handleIncomingLinks(BuildContext context) {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(context, uri);
      }
    }, onError: (err) {
      print('Deep link error: $err');
    });
  }

  Future<void> _handleInitialUri(BuildContext context) async {
    try {
      final uri = await getInitialUri();
      if (uri != null) {
        _handleDeepLink(context, uri);
      }
    } catch (err) {
      print('Initial URI error: $err');
    }
  }

  void _handleDeepLink(BuildContext context, Uri uri) {
    // Deep link format: moviesapp://movie/{movieId}
    if (uri.host == 'movie' && uri.pathSegments.isNotEmpty) {
      final movieIdStr = uri.pathSegments[0];
      final movieId = int.tryParse(movieIdStr);

      if (movieId != null) {
        // Navigate to movie detail screen
        Navigator.pushNamed(
          context,
          '/movie',
          arguments: movieId,
        );
      }
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}
