import 'package:flutter/material.dart';

import 'services/app_scope.dart';
import 'services/favorites_service.dart';
import 'services/scan_service.dart';
import 'services/skin_profile_service.dart';
import 'ui/common/app_theme.dart';
import 'ui/views/main_shell_view.dart';
import 'ui/views/splash_view.dart';

class CaiaApp extends StatefulWidget {
  const CaiaApp({super.key});

  @override
  State<CaiaApp> createState() => _CaiaAppState();
}

class _CaiaAppState extends State<CaiaApp> {
  final _skinProfileService = SkinProfileService();
  final _scanService = ScanService();
  final _favoritesService = FavoritesService();
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      skinProfileService: _skinProfileService,
      scanService: _scanService,
      favoritesService: _favoritesService,
      child: MaterialApp(
        title: 'CAIA Cosmetics',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: _showSplash
            ? SplashView(
                onFinished: () => setState(() => _showSplash = false),
              )
            : const MainShellView(),
      ),
    );
  }
}
