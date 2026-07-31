import 'package:flutter/material.dart';

class FadeInMenuItem extends StatefulWidget {
  final Widget child;
  const FadeInMenuItem({super.key, required this.child});

  @override
  State<FadeInMenuItem> createState() => _FadeInMenuItemState();
}

class _FadeInMenuItemState extends State<FadeInMenuItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 250), // 💡 Smooth animation window
    vsync: this,
  );

  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  late final Animation<Offset> _slideAnimation = Tween<Offset>(
    begin: const Offset(0, -0.15), // Slides down slightly from the top
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    _controller.forward(); // Fire the animation as soon as the item drops in
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
    );
  }
}
