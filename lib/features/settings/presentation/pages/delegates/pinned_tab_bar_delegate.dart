import 'package:flutter/material.dart';

class PinnedTabBarDelegate extends SliverPersistentHeaderDelegate {
  const PinnedTabBarDelegate({
    required this.child,
    required this.height,
    this.topInset = 0,
    this.backgroundColor,
    this.shadowColor = const Color(0x14000000),
  });

  final Widget child;
  final double height;
  final double topInset;
  final Color? backgroundColor;
  final Color? shadowColor;

  @override
  double get minExtent => height + topInset;
  @override
  double get maxExtent => height + topInset;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: shadowColor ?? Color(0x14000000),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : const [],
      ),
      padding: EdgeInsets.only(top: topInset),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  @override
  bool shouldRebuild(PinnedTabBarDelegate old) =>
      old.child != child ||
      old.height != height ||
      old.topInset != topInset ||
      old.backgroundColor != backgroundColor ||
      old.shadowColor != shadowColor;
}
