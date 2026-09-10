import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../services/app_scope.dart';
import '../../services/product_catalog.dart';
import '../common/app_colors.dart';
import '../common/app_layout.dart';
import '../shared_widgets/app_space.dart';
import '../shared_widgets/pressable_card.dart';
import 'product_detail_view.dart';

class RecommendationsView extends StatelessWidget {
  const RecommendationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final scan = AppScope.of(context).scanService;
    final profile = AppScope.of(context).skinProfileService;
    final products = scan.latestResult != null
        ? scan.recommendedProducts
        : ProductCatalog.forConcerns(profile.concerns);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: AppLayout.tabContentPadding,
          sliver: SliverMainAxisGroup(
            slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'For deg',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppSpace.sm),
              Text(
                'Anbefalinger basert på hudscan og hudpasset profil.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpace.lg),
            ],
          ),
        ),
        SliverList.separated(
          itemCount: products.length,
          separatorBuilder: (context, index) => const SizedBox(height: AppSpace.md),
          itemBuilder: (context, index) {
            final product = products[index];
            return _ProductCard(product: product);
          },
        ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final favorites = AppScope.of(context).favoritesService;

    return ListenableBuilder(
      listenable: favorites,
      builder: (context, _) {
        return PressableCard(
          padding: EdgeInsets.zero,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => ProductDetailView(productId: product.id),
              ),
            );
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                ),
                child: Image.asset(
                  product.imageAsset,
                  width: 110,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpace.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: AppSpace.xxs),
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpace.xs),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: AppSpace.sm),
                      Row(
                        children: [
                          Text(
                            product.priceLabel,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => favorites.toggle(product.id),
                            icon: Icon(
                              favorites.isFavorite(product.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
