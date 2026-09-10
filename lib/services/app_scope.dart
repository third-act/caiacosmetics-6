import 'package:flutter/widgets.dart';

import 'favorites_service.dart';
import 'scan_service.dart';
import 'skin_profile_service.dart';

class AppScope extends InheritedNotifier<SkinProfileService> {
  const AppScope({
    super.key,
    required this.scanService,
    required this.favoritesService,
    required SkinProfileService skinProfileService,
    required super.child,
  }) : super(notifier: skinProfileService);

  final ScanService scanService;
  final FavoritesService favoritesService;

  SkinProfileService get skinProfileService => notifier!;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found');
    return scope!;
  }
}
