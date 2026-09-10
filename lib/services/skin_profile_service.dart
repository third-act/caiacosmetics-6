import 'package:flutter/foundation.dart';

import '../models/models.dart';

class SkinProfileService extends ChangeNotifier {
  SkinProfileService()
      : _profile = const SkinProfile(
          displayName: 'Emma',
          skinType: 'Kombinert',
          primaryConcerns: [
            SkinConcern.hydration,
            SkinConcern.redness,
          ],
          notes: 'Sensitiv T-sone, tørre kinn.',
        );

  SkinProfile _profile;

  SkinProfile get profile => _profile;

  String get skinTypeLabel => _profile.skinType;

  List<SkinConcern> get concerns => List.unmodifiable(_profile.primaryConcerns);

  void updateProfile({
    String? displayName,
    String? skinType,
    List<SkinConcern>? primaryConcerns,
    String? notes,
  }) {
    _profile = _profile.copyWith(
      displayName: displayName,
      skinType: skinType,
      primaryConcerns: primaryConcerns,
      notes: notes,
    );
    notifyListeners();
  }

  void applyScanResult(ScanResult result) {
    final concerns = result.zones.map((zone) => zone.concern).toSet().toList();
    _profile = _profile.copyWith(
      primaryConcerns: concerns.isEmpty ? _profile.primaryConcerns : concerns,
      notes: result.summary,
    );
    notifyListeners();
  }
}
