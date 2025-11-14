import 'package:go_router/go_router.dart';
import 'package:prac9/features/water_tracker/presentation/screens/water_tracker_screen.dart';
import 'package:prac9/features/water_tracker/presentation/screens/add_intake_screen.dart';
import 'package:prac9/features/water_tracker/presentation/screens/statistics_screen.dart';
import 'package:prac9/features/water_tracker/presentation/screens/history_screen.dart';
import 'package:prac9/features/gallery/presentation/screens/network_images_screen.dart';
import 'package:prac9/features/settings/presentation/screens/settings_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const WaterTrackerScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'add',
            name: 'add',
            builder: (context, state) => const AddIntakeScreen(),
          ),
          GoRoute(
            path: 'statistics',
            name: 'statistics',
            builder: (context, state) => const StatisticsScreen(),
          ),
          GoRoute(
            path: 'history',
            name: 'history',
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: 'gallery',
            name: 'gallery',
            builder: (context, state) => const NetworkImagesScreen(),
          ),
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}