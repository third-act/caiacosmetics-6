import 'package:flutter/material.dart';

class ChevronBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChevronBackAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  final String title;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, size: 32),
        onPressed: onBack ?? () => Navigator.of(context).maybePop(),
      ),
      title: Text(title),
      centerTitle: false,
    );
  }
}
