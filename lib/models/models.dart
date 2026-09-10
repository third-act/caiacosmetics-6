enum SkinConcern {
  hydration,
  redness,
  glow,
  blemishes,
  barrier,
}

extension SkinConcernLabel on SkinConcern {
  String get nbLabel => switch (this) {
        SkinConcern.hydration => 'Fukt',
        SkinConcern.redness => 'Rødhet',
        SkinConcern.glow => 'Glød',
        SkinConcern.blemishes => 'Urenheter',
        SkinConcern.barrier => 'Hudbarriere',
      };
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.priceNok,
    required this.imageAsset,
    required this.description,
    required this.concerns,
    required this.howToUse,
    required this.ingredients,
  });

  final String id;
  final String name;
  final String category;
  final int priceNok;
  final String imageAsset;
  final String description;
  final List<SkinConcern> concerns;
  final String howToUse;
  final String ingredients;

  String get priceLabel => '$priceNok kr';
}

class SkinZone {
  const SkinZone({
    required this.id,
    required this.label,
    required this.concern,
    required this.intensity,
  });

  final String id;
  final String label;
  final SkinConcern concern;
  final double intensity;
}

class ScanResult {
  const ScanResult({
    required this.zones,
    required this.summary,
    required this.recommendedProductIds,
    required this.completedAt,
  });

  final List<SkinZone> zones;
  final String summary;
  final List<String> recommendedProductIds;
  final DateTime completedAt;
}

class SkinProfile {
  const SkinProfile({
    required this.displayName,
    required this.skinType,
    required this.primaryConcerns,
    required this.notes,
  });

  final String displayName;
  final String skinType;
  final List<SkinConcern> primaryConcerns;
  final String notes;

  SkinProfile copyWith({
    String? displayName,
    String? skinType,
    List<SkinConcern>? primaryConcerns,
    String? notes,
  }) {
    return SkinProfile(
      displayName: displayName ?? this.displayName,
      skinType: skinType ?? this.skinType,
      primaryConcerns: primaryConcerns ?? this.primaryConcerns,
      notes: notes ?? this.notes,
    );
  }
}
