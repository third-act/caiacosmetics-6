import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../services/app_scope.dart';
import '../../services/product_catalog.dart';
import '../common/app_colors.dart';
import '../shared_widgets/app_space.dart';
import '../shared_widgets/chevron_back_app_bar.dart';
import '../shared_widgets/pressable_card.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final product = ProductCatalog.byId(productId);
    final favorites = AppScope.of(context).favoritesService;
    final profile = AppScope.of(context).skinProfileService.profile;

    if (product == null) {
      return Scaffold(
        appBar: const ChevronBackAppBar(title: 'Produkt'),
        body: const Center(child: Text('Produkt ikke funnet')),
      );
    }

    return ListenableBuilder(
      listenable: favorites,
      builder: (context, _) {
        return Scaffold(
          appBar: ChevronBackAppBar(
            title: product.name,
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  product.imageAsset,
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: AppSpace.lg),
              Text(product.category, style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: AppSpace.xxs),
              Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: AppSpace.xs),
              Text(product.priceLabel, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpace.lg),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => favorites.toggle(product.id),
                      child: Text(
                        favorites.isFavorite(product.id)
                            ? 'Fjern fra favoritter'
                            : 'Legg til favoritter',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpace.lg),
              _HudpassetBanner(profile: profile, product: product),
              const SizedBox(height: AppSpace.lg),
              Text('Beskrivelse', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpace.xs),
              Text(product.description, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: AppSpace.lg),
              Text('Passer for', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpace.sm),
              Wrap(
                spacing: AppSpace.xs,
                children: [
                  for (final concern in product.concerns)
                    Chip(label: Text(concern.nbLabel)),
                ],
              ),
              const SizedBox(height: AppSpace.lg),
              Text('Sånn gjør du', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpace.xs),
              Text(product.howToUse, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: AppSpace.lg),
              Text('Ingredienser', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpace.xs),
              Text(product.ingredients, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        );
      },
    );
  }
}

class _HudpassetBanner extends StatelessWidget {
  const _HudpassetBanner({
    required this.profile,
    required this.product,
  });

  final SkinProfile profile;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final matches = profile.primaryConcerns
        .where((concern) => product.concerns.contains(concern))
        .toList();

    return PressableCard(
      backgroundColor: AppColors.blush.withValues(alpha: 0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hudpasset for ${profile.displayName}',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpace.xs),
          Text(
            matches.isEmpty
                ? 'Basert på ${profile.skinType.toLowerCase()} hud.'
                : 'Matcher ${matches.map((c) => c.nbLabel.toLowerCase()).join(', ')} fra profilen din.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
