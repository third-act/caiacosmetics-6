import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../services/app_scope.dart';
import '../common/app_colors.dart';
import '../common/app_layout.dart';
import '../shared_widgets/app_space.dart';
import '../shared_widgets/chevron_back_app_bar.dart';
import '../shared_widgets/pressable_card.dart';
import 'product_detail_view.dart';

class ScanResultView extends StatelessWidget {
  const ScanResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final scan = AppScope.of(context).scanService;
    final result = scan.latestResult;
    final products = scan.recommendedProducts;

    if (result == null) {
      return Scaffold(
        appBar: const ChevronBackAppBar(title: 'Resultat'),
        body: const Center(child: Text('Ingen scan ennå')),
      );
    }

    return Scaffold(
      appBar: const ChevronBackAppBar(title: 'Resultat'),
      body: ListView(
        padding: AppLayout.pagePadding.copyWith(
          top: AppSpace.md,
          bottom: AppSpace.xxl,
        ),
        children: [
          Text(
            'Din hudanalyse',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpace.sm),
          Text(result.summary, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: AppSpace.lg),
          Text('Soner', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpace.sm),
          for (final zone in result.zones) ...[
            PressableCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(zone.label, style: Theme.of(context).textTheme.titleMedium),
                        Text(zone.concern.nbLabel),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: LinearProgressIndicator(
                      value: zone.intensity,
                      backgroundColor: AppColors.blush.withValues(alpha: 0.35),
                      color: AppColors.ink,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpace.sm),
          ],
          const SizedBox(height: AppSpace.lg),
          Text('Anbefalinger', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpace.sm),
          for (final product in products) ...[
            PressableCard(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => ProductDetailView(productId: product.id),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(product.imageAsset, width: 72, height: 92, fit: BoxFit.cover),
                  const SizedBox(width: AppSpace.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: Theme.of(context).textTheme.titleMedium),
                        Text(product.priceLabel),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
            const SizedBox(height: AppSpace.sm),
          ],
        ],
      ),
    );
  }
}
