import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/contacts/presentation/contacts_providers/contacts_providers.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_tab_bar.dart';
import 'package:mess_messenger_app/features/contacts/presentation/widgets/reusable/contacts_tabs_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MobileContactDetailsPage extends ConsumerStatefulWidget {
  final String? contactUserId;
  final String? initialTab;
  const MobileContactDetailsPage({
    super.key,
    this.contactUserId,
    this.initialTab,
  });

  @override
  ConsumerState<MobileContactDetailsPage> createState() =>
      _MobileContactDetailsPageState();
}

class _MobileContactDetailsPageState
    extends ConsumerState<MobileContactDetailsPage>
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

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        final tab = ContactsTab.values[tabController.index];
        GoRouter.of(
          context,
        ).replace(AppRoutes.contactDetailsFor(widget.contactUserId ?? '', tab));
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);
    if (!bp.isMobile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref
            .read(contactsNotifierProvider.notifier)
            .selectContact(widget.contactUserId ?? '');
        context.go(AppRoutes.contacts);
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final contact = ref
        .watch(watchedUserProvider(widget.contactUserId ?? ''))
        .value;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MobileAppBar(
        userName: contact?.name,
        userEmail: contact?.email,
        appBarUserPhotoPath: contact?.avatarUrl,
        appBarBackgroundColor: colors.transparent,
        resizeToAvoidBottomInset: false,
        showAppBarContent: true,
        showBottomLine: false,
        onPressedBack: () => context.pop(),
        actions: [
          MessIconDropdownButton<DropdownItemAction>(
            svgAsset: SvgIcons.menuVert,
            isButtonFilled: true,
            borderWidth: 0,
            itemLabelBuilder: (item) => item.label,
            textColorBuilder: (item) => item.textColor,
            onItemTap: (item) => item.onTap(),
            items: [
              DropdownItemAction(
                label: l10n.message,
                onTap: () => ref
                    .read(contactsNotifierProvider.notifier)
                    .openChatWith(
                      widget.contactUserId ?? '',
                      isDesktop: bp.isDesktop,
                    ),
              ),
              DropdownItemAction(
                label: l10n.search,
                onTap: () {}, //widget.onPressedChangeAvatar,
              ),
              DropdownItemAction(label: l10n.muteNotifications, onTap: () {}),
              DropdownItemAction(
                label: l10n.clearChat,
                onTap: () {}, //widget.onPressedLogoutFromAllDevices,
              ),
              DropdownItemAction(
                label: l10n.blockUser,
                onTap: () {}, //widget.onPressedContactSupport,
              ),
            ],
          ),
          AppSpacing.p16.gapH,
        ],
      ),

      body: Column(
        children: [
          ContactsTabsBar(tabController: tabController),
          Expanded(
            child: ContactsTabsWidget(
              tabController: tabController,
              contactUserId: widget.contactUserId ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
