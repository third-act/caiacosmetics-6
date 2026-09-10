import 'package:flutter/material.dart';

import '../../services/app_scope.dart';
import '../../services/scan_service.dart';
import '../common/app_colors.dart';
import '../common/app_layout.dart';
import '../shared_widgets/app_space.dart';
import '../shared_widgets/pressable_card.dart';
import 'scan_result_view.dart';

class HudscanView extends StatefulWidget {
  const HudscanView({super.key});

  @override
  State<HudscanView> createState() => _HudscanViewState();
}

class _HudscanViewState extends State<HudscanView> {
  @override
  Widget build(BuildContext context) {
    final scan = AppScope.of(context).scanService;

    return ListenableBuilder(
      listenable: scan,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hudscan',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppSpace.sm),
              Text(
                'Ta et bilde, kartlegg hudsoner og få personlige anbefalinger.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpace.lg),
              Expanded(
                child: switch (scan.stage) {
                  ScanStage.pickPhoto => _PickPhotoStep(scan: scan),
                  ScanStage.zoneMap => _ZoneMapStep(scan: scan),
                  ScanStage.result => _ResultStep(scan: scan),
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PickPhotoStep extends StatelessWidget {
  const _PickPhotoStep({required this.scan});

  final ScanService scan;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Steg 1 · Velg bilde', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpace.md),
        Expanded(
          child: SingleChildScrollView(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                ScanService.stagedPortraitAsset,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpace.md),
        Text(
          'Staged profilbilde klart for hudscan',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpace.md),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => scan.pickPhoto(ScanService.stagedPortraitAsset),
            child: const Text('Fortsett'),
          ),
        ),
      ],
    );
  }
}

class _ZoneMapStep extends StatelessWidget {
  const _ZoneMapStep({required this.scan});

  final ScanService scan;

  @override
  Widget build(BuildContext context) {
    final photoAsset = scan.pickedPhotoAsset ?? ScanService.stagedPortraitAsset;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Steg 2 · Soner', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpace.md),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Image.asset(
                        photoAsset,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _ZonePainter(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpace.md),
                Wrap(
                  spacing: AppSpace.sm,
                  runSpacing: AppSpace.sm,
                  children: const [
                    _ZoneChip(label: 'Panne · Fukt'),
                    _ZoneChip(label: 'Kinn · Rødhet'),
                    _ZoneChip(label: 'Nese · Urenheter'),
                    _ZoneChip(label: 'Hake · Barriere'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpace.md),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await scan.analyzeZones();
              if (!context.mounted) return;
              AppScope.of(context).skinProfileService.applyScanResult(
                    scan.latestResult!,
                  );
            },
            child: const Text('Analyser hudsoner'),
          ),
        ),
      ],
    );
  }
}

class _ResultStep extends StatelessWidget {
  const _ResultStep({required this.scan});

  final ScanService scan;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(bottom: AppLayout.tabClearance),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Steg 3 · Resultat', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpace.md),
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
                        scan.latestResult?.summary ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: AppSpace.sm),
                      Text(
                        'Se fullt resultat og anbefalinger',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.hover,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpace.md),
                OutlinedButton(
                  onPressed: scan.reset,
                  child: const Text('Ny scan'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ZoneChip extends StatelessWidget {
  const _ZoneChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: AppColors.blush.withValues(alpha: 0.35),
    );
  }
}

class _ZonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = AppColors.blush.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = AppColors.blush.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final zones = [
      Rect.fromLTWH(size.width * 0.25, size.height * 0.08, size.width * 0.5, size.height * 0.18),
      Rect.fromLTWH(size.width * 0.08, size.height * 0.32, size.width * 0.28, size.height * 0.22),
      Rect.fromLTWH(size.width * 0.64, size.height * 0.32, size.width * 0.28, size.height * 0.22),
      Rect.fromLTWH(size.width * 0.36, size.height * 0.34, size.width * 0.28, size.height * 0.18),
      Rect.fromLTWH(size.width * 0.3, size.height * 0.68, size.width * 0.4, size.height * 0.16),
    ];

    for (final zone in zones) {
      final rrect = RRect.fromRectAndRadius(zone, const Radius.circular(12));
      canvas.drawRRect(rrect, fillPaint);
      canvas.drawRRect(rrect, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
