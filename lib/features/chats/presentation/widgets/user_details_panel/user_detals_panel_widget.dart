import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_text_button.dart';
import 'package:mess_messenger_app/core/widgets/user_avatar_widget.dart';
import 'package:mess_messenger_app/core/widgets/user_data_content_widget.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/chat/buttons_panel_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/message_card_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/user_details_panel/section_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserDetailsPanelWidget extends ConsumerWidget {
  const UserDetailsPanelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);

    final sectionWidth = bp.isDesktop
        ? bp.screenWidth * 0.2
        : bp.screenWidth * 0.35;

    final selectedChatId =
        GoRouterState.of(context).uri.queryParameters['c'] ?? '';

    final otherUser = selectedChatId.isEmpty
        ? null
        : ref.watch(
            chatsNotifierProvider(selectedChatId).select((s) => s.otherUser),
          );

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
                  clipBehavior: .none,
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
                              fit: .cover,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 24, top: 60),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                otherUser?.name ?? 'No Name',
                                style: textTheme.displaySmall?.copyWith(
                                  color: colors.text1,
                                ),
                              ),

                              AppSpacing.p4.gapV,

                              Text(
                                otherUser?.phoneNumber ?? '+44656548060',
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
                              ButtonsPanelWidget(),
                              SectionWidget(
                                title: l10n.status,
                                widgets: [
                                  Text(
                                    'When there’s no more hope, think of the lobster in the  restaurant’s aquarium of the Titanic.',
                                    style: textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              SectionWidget(
                                title: l10n.savedMessages,
                                widgets: [
                                  MessageCardWidget(),

                                  MessTextButton(label: l10n.showMore),
                                ],
                              ),
                              SectionWidget(
                                title: l10n.groups,
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
                        clipBehavior: .none,
                        children: [
                          UserAvatarWidget(
                            isOnline: false,
                            userName: otherUser?.name ?? '?',
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
                      onPressed: () => ref
                          .read(userChatsNotifierProvider.notifier)
                          .toggleDisplayProfileDetails(),
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
