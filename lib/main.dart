import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'customs/custom_loader.dart';
import 'riverpod/loading_state_riverpod.dart';
import 'routes/app_route.dart';
import 'routes/route_path.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return MaterialApp(
      title: 'Appwise',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      initialRoute: RoutePath.splashScreen,
      navigatorObservers: [routeObserver],
      onGenerateRoute: AppRoute().onGenerateRoute,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              child!,
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Loader(),
                ),
            ],
          ),
        );
      },
    );
  }
}
