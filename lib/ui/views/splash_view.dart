import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../shared_widgets/app_space.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    Future<void>.delayed(const Duration(milliseconds: 1800), widget.onFinished);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/brand/logo.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: AppSpace.lg),
              Text(
                'CAIA Cosmetics',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpace.xs),
              Text(
                'Hudpleie for deg',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.hover,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
