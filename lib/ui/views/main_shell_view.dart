import 'package:flutter/material.dart';

import '../shared_widgets/tab_pill.dart';
import 'favorites_view.dart';
import 'home_view.dart';
import 'hudscan_view.dart';
import 'profile_view.dart';
import 'recommendations_view.dart';

class MainShellView extends StatefulWidget {
  const MainShellView({super.key});

  @override
  State<MainShellView> createState() => MainShellViewState();
}

class MainShellViewState extends State<MainShellView> {
  int _index = 0;

  void goToTab(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return TabShell(
      body: IndexedStack(
        index: _index,
        children: [
          HomeView(onStartScan: () => goToTab(1)),
          const HudscanView(),
          const RecommendationsView(),
          const FavoritesView(),
          const ProfileView(),
        ],
      ),
      tabPill: TabPill(
        currentIndex: _index,
        onTap: goToTab,
        items: const [
          TabPillItem(icon: Icons.home_outlined, label: 'Hjem'),
          TabPillItem(icon: Icons.face_retouching_natural_outlined, label: 'Hudscan'),
          TabPillItem(icon: Icons.auto_awesome_outlined, label: 'For deg'),
          TabPillItem(icon: Icons.favorite_border, label: 'Favoritter'),
          TabPillItem(icon: Icons.person_outline, label: 'Min'),
        ],
      ),
    );
  }
}
