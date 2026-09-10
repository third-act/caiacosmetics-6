import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/app_layout.dart';
import 'app_shadows.dart';
import 'app_space.dart';

class TabPillItem {
  const TabPillItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class TabPill extends StatelessWidget {
  const TabPill({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<TabPillItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16 + bottomInset),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: AppShadows.tabPill,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _TabCell(
                    item: items[i],
                    selected: currentIndex == i,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabCell extends StatelessWidget {
  const _TabCell({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final TabPillItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.ink : AppColors.hover;
    return Material(
      color: selected ? AppColors.blush.withValues(alpha: 0.45) : Colors.transparent,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icon, size: 22, color: color),
              const SizedBox(height: AppSpace.xxs),
              Text(
                item.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reserve bottom space outside IndexedStack for floating TabPill.
class TabShell extends StatelessWidget {
  const TabShell({
    super.key,
    required this.body,
    required this.tabPill,
  });

  final Widget body;
  final Widget tabPill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.only(
          bottom: AppLayout.tabClearance + MediaQuery.paddingOf(context).bottom,
        ),
        child: body,
      ),
      bottomNavigationBar: tabPill,
    );
  }
}
