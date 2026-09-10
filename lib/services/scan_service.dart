import 'package:flutter/foundation.dart';

import '../models/models.dart';
import 'product_catalog.dart';

enum ScanStage { pickPhoto, zoneMap, result }

class ScanService extends ChangeNotifier {
  ScanStage _stage = ScanStage.pickPhoto;
  String? _pickedPhotoAsset;
  ScanResult? _latestResult;

  ScanStage get stage => _stage;
  String? get pickedPhotoAsset => _pickedPhotoAsset;
  ScanResult? get latestResult => _latestResult;

  static const onskeVerbatim =
      'Man ska kunna scanna ansiktet och få rekommendationer på vilka produkter som passar min hud';

  static const stagedPortraitAsset = 'assets/scan/c6-staged-portrait.jpg';

  void reset() {
    _stage = ScanStage.pickPhoto;
    _pickedPhotoAsset = null;
    notifyListeners();
  }

  void pickPhoto(String assetPath) {
    _pickedPhotoAsset = assetPath;
    _stage = ScanStage.zoneMap;
    notifyListeners();
  }

  Future<void> analyzeZones() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    _latestResult = ScanResult(
      zones: const [
        SkinZone(
          id: 'forehead',
          label: 'Panne',
          concern: SkinConcern.hydration,
          intensity: 0.62,
        ),
        SkinZone(
          id: 'cheeks',
          label: 'Kinn',
          concern: SkinConcern.redness,
          intensity: 0.74,
        ),
        SkinZone(
          id: 'nose',
          label: 'Nese',
          concern: SkinConcern.blemishes,
          intensity: 0.48,
        ),
        SkinZone(
          id: 'chin',
          label: 'Hake',
          concern: SkinConcern.barrier,
          intensity: 0.55,
        ),
      ],
      summary:
          'Kombinert hud med behov for fukt, beroligende pleie og lett eksfoliering i T-sone.',
      recommendedProductIds: const [
        'c6-cica-care-serum',
        'c6-soothing-serum',
        'c6-bha-exfoliate',
        'c6-hydrating-cream',
      ],
      completedAt: DateTime.now(),
    );
    _stage = ScanStage.result;
    notifyListeners();
  }

  List<Product> get recommendedProducts =>
      ProductCatalog.byIds(_latestResult?.recommendedProductIds ?? const []);
}
