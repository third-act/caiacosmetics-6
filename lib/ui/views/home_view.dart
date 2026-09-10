import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../services/app_scope.dart';
import '../../services/scan_service.dart';
import '../common/app_colors.dart';
import '../common/app_layout.dart';
import '../shared_widgets/app_space.dart';
import '../shared_widgets/pressable_card.dart';
import 'scan_result_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.onStartScan});

  final VoidCallback onStartScan;

  static const onskeVerbatim = ScanService.onskeVerbatim;

  @override
  Widget build(BuildContext context) {
    final scan = AppScope.of(context).scanService;
    final profile = AppScope.of(context).skinProfileService.profile;
    final latest = scan.latestResult;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: AppLayout.tabContentPadding,
          sliver: SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hei, ${profile.displayName}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppSpace.sm),
              Text(
                'Din personlige hudpleieopplevelse starter med en rask hudscan.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpace.lg),
              PressableCard(
                onTap: onStartScan,
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.blush.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.face_retouching_natural_outlined),
                    ),
                    const SizedBox(width: AppSpace.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start hudscan',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpace.xxs),
                          Text(
                            'Få anbefalinger tilpasset huden din',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
              const SizedBox(height: AppSpace.lg),
              Text(
                'Onske (Sverige)',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSpace.xs),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpace.md),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.blush),
                ),
                child: Text(
                  onskeVerbatim,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
              if (latest != null) ...[
                const SizedBox(height: AppSpace.lg),
                Text(
                  'Siste resultat',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpace.sm),
                PressableCard(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const ScanResultView(),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        latest.summary,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: AppSpace.sm),
                      Wrap(
                        spacing: AppSpace.xs,
                        runSpacing: AppSpace.xs,
                        children: [
                          for (final zone in latest.zones)
                            Chip(
                              label: Text(zone.label),
                              backgroundColor: AppColors.blush.withValues(alpha: 0.35),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppSpace.lg),
              Text(
                'Hudpasset profil',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpace.sm),
              _ProfileSummary(profile: profile),
            ],
          ),
        ),
        ),
      ],
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({required this.profile});

  final SkinProfile profile;

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hudtype: ${profile.skinType}'),
          const SizedBox(height: AppSpace.xs),
          Wrap(
            spacing: AppSpace.xs,
            children: [
              for (final concern in profile.primaryConcerns)
                Chip(label: Text(concern.nbLabel)),
            ],
          ),
        ],
      ),
    );
  }
}
