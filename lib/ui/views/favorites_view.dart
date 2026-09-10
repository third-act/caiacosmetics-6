import 'package:flutter/material.dart';

import '../../services/app_scope.dart';
import '../../services/product_catalog.dart';
import '../common/app_layout.dart';
import '../shared_widgets/app_space.dart';
import '../shared_widgets/pressable_card.dart';
import 'product_detail_view.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = AppScope.of(context).favoritesService;

    return ListenableBuilder(
      listenable: favorites,
      builder: (context, _) {
        final products = ProductCatalog.byIds(favorites.favoriteIds);

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
                    'Favoritter',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppSpace.sm),
                  Text(
                    'Produkter du har lagret — tilpasset hudprofilen din.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpace.lg),
                ],
              ),
            ),
            if (products.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('Ingen favoritter ennå')),
              )
            else
              SliverList.separated(
                itemCount: products.length,
                separatorBuilder: (context, index) => const SizedBox(height: AppSpace.md),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return PressableCard(
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
                        IconButton(
                          onPressed: () => favorites.toggle(product.id),
                          icon: const Icon(Icons.favorite),
                        ),
                      ],
                    ),
                  );
                },
              ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
