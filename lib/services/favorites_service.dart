import 'package:flutter/foundation.dart';

class FavoritesService extends ChangeNotifier {
  final Set<String> _favoriteIds = {'c6-cica-care-serum', 'c6-soothing-serum'};

  List<String> get favoriteIds => _favoriteIds.toList();

  bool isFavorite(String productId) => _favoriteIds.contains(productId);

  void toggle(String productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
  }
}
