import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac9/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:prac9/features/water_tracker/presentation/screens/water_tracker_screen.dart';
import 'package:prac9/features/water_tracker/presentation/screens/add_intake_screen.dart';
import 'package:prac9/features/water_tracker/presentation/screens/statistics_screen.dart';
import 'package:prac9/features/water_tracker/presentation/screens/history_screen.dart';
import 'package:prac9/features/gallery/presentation/screens/network_images_screen.dart';
import 'package:prac9/features/settings/presentation/screens/settings_screen.dart';
import 'package:prac9/features/water_tracker/presentation/cubits/water_tracker_cubit.dart';
import 'package:prac9/features/water_tracker/presentation/cubits/statistics_cubit.dart';
import 'package:prac9/features/water_tracker/presentation/cubits/history_cubit.dart';
import 'package:prac9/features/water_tracker/presentation/cubits/add_intake_cubit.dart';


class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<WaterTrackerCubit>(
              create: (context) => WaterTrackerCubit(),
            ),
            BlocProvider<SettingsCubit>(
              create: (context) => SettingsCubit(),
            ),
          ],
          child: const WaterTrackerScreen(),
        ),
        routes: <RouteBase>[
          GoRoute(
            path: 'add',
            name: 'add',
            builder: (context, state) => BlocProvider(
              create: (context) => AddIntakeCubit(),
              child: const AddIntakeScreen(),
            ),
          ),
          GoRoute(
            path: 'statistics',
            name: 'statistics',
            builder: (context, state) => BlocProvider(
              create: (context) => StatisticsCubit(),
              child: const StatisticsScreen(),
            ),
          ),
          GoRoute(
            path: 'history',
            name: 'history',
            builder: (context, state) => BlocProvider(
              create: (context) => HistoryCubit(),
              child: const HistoryScreen(),
            ),
          ),
          GoRoute(
            path: 'gallery',
            name: 'gallery',
            builder: (context, state) => const NetworkImagesScreen(),
          ),
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) => BlocProvider(
              create: (context) => SettingsCubit(),
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
}