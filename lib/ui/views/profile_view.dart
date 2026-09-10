import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../services/app_scope.dart';
import '../common/app_layout.dart';
import '../shared_widgets/app_space.dart';
import '../shared_widgets/brand_field.dart';
import '../shared_widgets/pressable_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  String _skinType = 'Kombinert';
  late List<SkinConcern> _concerns;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final profile = AppScope.of(context).skinProfileService.profile;
    _nameController = TextEditingController(text: profile.displayName);
    _notesController = TextEditingController(text: profile.notes);
    _skinType = profile.skinType;
    _concerns = List.of(profile.primaryConcerns);
  }

  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    AppScope.of(context).skinProfileService.updateProfile(
          displayName: _nameController.text.trim(),
          skinType: _skinType,
          primaryConcerns: _concerns,
          notes: _notesController.text.trim(),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil oppdatert')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: AppLayout.tabContentPadding,
          sliver: SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Min profil', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: AppSpace.sm),
              Text(
                'Hudpasset profil deles på tvers av detalj, favoritter og profil.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpace.lg),
              BrandField(
                controller: _nameController,
                label: 'Navn',
              ),
              const SizedBox(height: AppSpace.lg),
              Text('Hudtype', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpace.sm),
              Wrap(
                spacing: AppSpace.xs,
                children: [
                  for (final type in ['Tørr', 'Fet', 'Kombinert', 'Sensitiv'])
                    ChoiceChip(
                      label: Text(type),
                      selected: _skinType == type,
                      onSelected: (_) => setState(() => _skinType = type),
                    ),
                ],
              ),
              const SizedBox(height: AppSpace.lg),
              Text('Hovedbehov', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpace.sm),
              Wrap(
                spacing: AppSpace.xs,
                runSpacing: AppSpace.xs,
                children: [
                  for (final concern in SkinConcern.values)
                    FilterChip(
                      label: Text(concern.nbLabel),
                      selected: _concerns.contains(concern),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _concerns.add(concern);
                          } else {
                            _concerns.remove(concern);
                          }
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: AppSpace.lg),
              BrandField(
                controller: _notesController,
                label: 'Notater',
                maxLines: 3,
              ),
              const SizedBox(height: AppSpace.lg),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Lagre profil'),
                ),
              ),
              const SizedBox(height: AppSpace.lg),
              PressableCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Konto', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: AppSpace.xs),
                    Text(
                      'Du er logget inn som CAIA-kunde (mock).',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
      ],
    );
  }
}
