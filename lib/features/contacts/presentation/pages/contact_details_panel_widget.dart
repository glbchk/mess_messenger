import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/user_data_content_widget.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/contacts/presentation/contacts_providers/contacts_providers.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_tab_bar.dart';
import 'package:mess_messenger_app/features/contacts/presentation/widgets/reusable/action_pill_button.dart';
import 'package:mess_messenger_app/features/contacts/presentation/widgets/reusable/contacts_tabs_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContactDetailsPanelWidget extends ConsumerStatefulWidget {
  final String? contactUserId;
  final String? initialTab;
  final VoidCallback? onClose;

  const ContactDetailsPanelWidget({
    super.key,
    this.contactUserId,
    this.initialTab,
    this.onClose,
  });
  @override
  ConsumerState<ContactDetailsPanelWidget> createState() =>
      _ContactDetailsPanelWidgetState();
}

class _ContactDetailsPanelWidgetState
    extends ConsumerState<ContactDetailsPanelWidget>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final targetTab = widget.initialTab ?? ContactsTab.overview.name;
    int initialIndex = ContactsTab.values.indexWhere(
      (tab) => tab.name == targetTab,
    );
    if (initialIndex == -1) initialIndex = 0;

    tabController = TabController(
      length: ContactsTab.values.length,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);

    final sectionWidth = bp.isDesktop
        ? bp.screenWidth * 0.2
        : bp.screenWidth * 0.35;

    final contactUser = ref
        .watch(watchedUserProvider(widget.contactUserId ?? ''))
        .value;

    return Container(
      width: sectionWidth,
      color: colors.surface0,
      child: Container(
        margin: bp.isDesktop
            ? const EdgeInsets.only(top: 20, right: 20, bottom: 20)
            : const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: colors.bg,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 24.0,
              ),
              child: Row(
                children: [
                  if (widget.onClose != null) ...[
                    MessIconButton(
                      SvgIcons.arrowLeft,
                      onPressed: widget.onClose,
                    ),
                    AppSpacing.p12.gapH,
                  ],
                  UserDataContentWidget(otherUserData: contactUser),
                  Spacer(),
                  Row(
                    spacing: 12,
                    children: [
                      MessMainButton(
                        label: l10n.message,
                        width: 160,
                        height: 44,
                        onPressed: () => ref
                            .read(contactsNotifierProvider.notifier)
                            .openChatWith(
                              widget.contactUserId ?? '',
                              isDesktop: bp.isDesktop,
                            ),
                      ),
                      ActionPillButton(onVideoTap: () {}, onPhoneTap: () {}),
                      MessIconDropdownButton(
                        svgAsset: SvgIcons.menuHorizontal,
                        isButtonFilled: true,
                        items: ['Some'],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ContactsTabsBar(tabController: tabController),

            Expanded(
              child: ContactsTabsWidget(
                tabController: tabController,
                contactUserId: widget.contactUserId ?? '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
