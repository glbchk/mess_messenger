import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_text_button.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/core/widgets/user_data_content_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/message_card_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/section_widget.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserDetailsPanelWidget extends StatelessWidget {
  final AppLocalizations l10n;
  final UserModel otherUserData;
  final VoidCallback? onPressedClose;

  const UserDetailsPanelWidget({
    super.key,
    required this.l10n,
    required this.otherUserData,
    this.onPressedClose,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

    final sectionWidth = bp.isDesktop
        ? bp.screenWidth * 0.2
        : bp.screenWidth * 0.35;

    return Container(
      width: sectionWidth,
      color: colors.surface0,
      child: Container(
        margin: bp.isDesktop
            ? const EdgeInsets.only(top: 20, right: 20, bottom: 20)
            : null,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: colors.bg,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Container(
                          height: 210,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                            color: colors.bg,
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                            child: Image.asset(
                              'assets/images/settings_header.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 24, top: 60),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                otherUserData.name ?? 'No Name',
                                style: textTheme.displaySmall?.copyWith(
                                  color: colors.text1,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                otherUserData.phoneNumber ?? '+44656548060',
                                style: textTheme.headlineMedium?.copyWith(
                                  color: colors.text2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.p40.gapV,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: .start,
                            spacing: 40,
                            children: [
                              Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                spacing: 32,
                                runSpacing: 16,
                                children: [
                                  _action(SvgIcons.calls, 'Call'),
                                  _action(SvgIcons.video, 'Video'),
                                  _action(SvgIcons.email, 'Email'),
                                  _action(SvgIcons.menuHorizontal, 'More'),
                                ],
                              ),
                              SectionWidget(
                                title: 'Status',
                                widgets: [
                                  Text(
                                    'When there’s no more hope, think of the lobster in the  restaurant’s aquarium of the Titanic.',
                                    style: textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              SectionWidget(
                                title: 'Saved messages',
                                widgets: [
                                  MessageCardWidget(),

                                  MessTextButton(label: 'Show more'),
                                ],
                              ),
                              SectionWidget(
                                title: 'Groups',
                                widgets: [
                                  UserDataContentWidget(
                                    avatarSize: 40,
                                    titleSize: textTheme.titleMedium,
                                    titleColor: colors.text1,
                                    subtitleSize: textTheme.bodyMedium,
                                    subtitleColor: colors.text2,
                                    mainAxisAlignment: .start,
                                  ),
                                ],
                              ),

                              AppSpacing.p60.gapV,
                            ],
                          ),
                        ),
                      ],
                    ),

                    Positioned(
                      left: 24,
                      top: 154,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          UserAvatarWidget(
                            isOnline: false,
                            userName: otherUserData.name ?? '?',
                            size: 96,
                            textStyle: textTheme.displayMedium?.copyWith(
                              color: colors.iconContrast,
                            ),
                            backgroundColor: colors.surface4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                right: 16,
                top: 16,
                child: Stack(
                  children: [
                    MessIconButton(
                      SvgIcons.close,
                      buttonSize: 32,
                      iconSize: 16,
                      onPressed: onPressedClose,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _action(String icon, String label) => Column(
  mainAxisSize: MainAxisSize.min,
  spacing: 16,
  children: [MessIconButton(icon, isButtonFilled: true), Text(label)],
);
