import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';

class ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  ProfileHeaderDelegate({
    required this.topInset,
    required this.userData,
    required this.textTheme,
    required this.colors,
    required this.onBack,
    required this.actions,
  });

  final double topInset;
  final UserModel userData;
  final TextTheme textTheme;
  final dynamic colors;
  final VoidCallback onBack;
  final Widget actions;

  static const double _imageBandHeight = 220;
  static const double _toolbarHeight = 72;
  static const double _contentReserve = 136;
  static const double _avatarRadius = 48;
  static const double _collapsedAvatarRadius = 18;

  double get _imageHeight => topInset + _imageBandHeight;

  @override
  double get minExtent => topInset + _toolbarHeight;
  @override
  double get maxExtent => _imageHeight + _contentReserve;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    final expandedTextOpacity = (1 - t / 0.4).clamp(0.0, 1.0);
    final expandedTextSlide = shrinkOffset;
    final collapsedTextOpacity = ((t - 0.85) / 0.15).clamp(0.0, 1.0);

    final labelBg = lerpDouble(24, 15, t)!;
    final labelSize = lerpDouble(24, 15, t)!;
    final avatarRadius = lerpDouble(_avatarRadius, _collapsedAvatarRadius, t)!;
    final avatarLeft = lerpDouble(24, 72, t)!;
    final avatarTop = lerpDouble(
      _imageHeight - _avatarRadius - 4,
      topInset + (_toolbarHeight - _collapsedAvatarRadius * 2) / 2,
      t,
    )!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: _imageHeight,
              child: IgnorePointer(
                ignoring: expandedTextOpacity == 0,
                child: Opacity(
                  opacity: expandedTextOpacity,
                  child: Image.asset(
                    'assets/images/settings_header.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              top: _imageHeight + 56 - expandedTextSlide,
              child: IgnorePointer(
                ignoring: expandedTextOpacity == 0,
                child: Opacity(
                  opacity: expandedTextOpacity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        userData.name ?? 'Sylvia Reyes',
                        style: textTheme.displaySmall?.copyWith(
                          color: colors.text1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userData.phoneNumber ?? '+44656548060',
                        style: textTheme.headlineMedium?.copyWith(
                          color: colors.text2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: topInset,
              left: 0,
              right: 0,
              height: _toolbarHeight,
              child: Container(
                color: colors.bg.withOpacity(t),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    MessIconButton(
                      SvgIcons.arrowLeft,
                      isButtonFilled: true,
                      borderWidth: 0,
                      onPressed: onBack,
                    ),
                    const SizedBox(width: 12),
                    SizedBox(width: _collapsedAvatarRadius * 2 + 10),
                    Expanded(
                      child: IgnorePointer(
                        ignoring: collapsedTextOpacity == 0,
                        child: Opacity(
                          opacity: collapsedTextOpacity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                userData.name ?? 'Sylvia Reyes',
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleMedium?.copyWith(
                                  color: colors.text1,
                                ),
                              ),
                              Text(
                                userData.phoneNumber ?? '+44656548060',
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: colors.text2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions,
                  ],
                ),
              ),
            ),

            Positioned(
              left: avatarLeft,
              top: avatarTop,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  UserAvatarWidget(
                    userName: userData.name ?? 'Sylvia Reyes',
                    photoPath: userData.avatarUrl,
                    size: avatarRadius * 2,
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Stack(
                      children: [
                        MessIcon(
                          SvgIcons.verifiedLabel,
                          color: colors.componentSpecific,
                          size: labelBg,
                        ),
                        MessIcon(
                          SvgIcons.verifiedCheckmark,
                          color: colors.bg,
                          size: labelSize,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant ProfileHeaderDelegate old) =>
      old.userData != userData || old.topInset != topInset;
}
