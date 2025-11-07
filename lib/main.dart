import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/search/search_bloc.dart';
import 'presentation/bloc/bookmark/bookmark_bloc.dart';
import 'presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'presentation/bloc/navigation/navigation_bloc.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/movie_detail_screen.dart';
import 'core/utils/deep_link_handler.dart';
import 'core/theme/app_theme.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && navigatorKey.currentContext != null) {
        DeepLinkHandler.instance.initialize(navigatorKey.currentContext!);
      }
    });
  }

  @override
  void dispose() {
    DeepLinkHandler.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<BookmarkBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<NavigationBloc>(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Movies Database',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == '/movie') {
            final movieId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movieId: movieId),
            );
          }
          return null;
        },
      ),
    );
  }
}
