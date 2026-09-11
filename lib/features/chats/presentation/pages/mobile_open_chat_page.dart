import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/mobile_bottom_input_bar.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/date_separator_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/received_message_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/sent_message_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/typing_indicator_widget.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/ui_helper/build_message_list_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MobileOpenChatPage extends ConsumerStatefulWidget {
  final String? chatId;
  final bool? textNewLineOrSend;
  const MobileOpenChatPage({super.key, this.chatId, this.textNewLineOrSend});

  @override
  ConsumerState<MobileOpenChatPage> createState() => _MobileOpenChatPageState();
}

class _MobileOpenChatPageState extends ConsumerState<MobileOpenChatPage> {
  final TextEditingController messageController = TextEditingController();
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    messageController.removeListener(_onTextChanged);
    _typingTimer?.cancel();
    messageController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final userId = ref.read(userNotifierProvider).userData?.id;
    if (userId == null) return;

    final notifier = ref.read(
      chatsNotifierProvider(widget.chatId ?? '').notifier,
    );

    _typingTimer?.cancel();

    if (messageController.text.isNotEmpty) {
      notifier.setTyping(userId, true);
      _typingTimer = Timer(const Duration(seconds: 3), () {
        notifier.setTyping(userId, false);
      });
    } else {
      notifier.setTyping(userId, false);
    }
  }

  void attachFile() {}

  void openEmojiPicker() {}

  //Need to add action to move to the next line

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final userData = ref.read(userNotifierProvider).userData;
    if (userData == null) {
      return;
    }

    _typingTimer?.cancel();
    final notifier = ref.read(
      chatsNotifierProvider(widget.chatId ?? '').notifier,
    );
    notifier.setTyping(userData.id, false);
    notifier.sendMessage(userData.id, text);

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    final bp = ResponsiveBreakpoints.of(context);
    if (!bp.isMobile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go(AppRoutes.chatsWithSelection(widget.chatId ?? ''));
        }
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentUserId = ref.watch(userNotifierProvider).userData?.id ?? '';
    final chatState = ref.watch(chatsNotifierProvider(widget.chatId ?? ''));

    final userData = ref.read(userNotifierProvider).userData;

    final peer = chatState.otherUser;

    final items = buildChatItems(chatState.messages, context);
    final otherIsTyping = chatState.typingUserIds.contains(
      chatState.otherUser?.id,
    );

    if (widget.chatId?.isEmpty ?? false) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MobileAppBar(
        userName: peer?.name,
        userEmail: peer?.email,
        appBarUserPhotoPath: peer?.avatarUrl,
        appBarBackgroundColor: colors.transparent,
        resizeToAvoidBottomInset: false,
        showAppBarContent: true,
        showBottomLine: true,
        onPressedBack: () => context.pop(),
        onPressedViewProfile: () =>
            context.push(AppRoutes.profileDetailsFor(widget.chatId ?? '')),
        // title: 'Chats',
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

      body: chatState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: items.length + (otherIsTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (otherIsTyping && index == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TypingIndicatorWidget(
                              userName: peer?.name ?? 'Other',
                            ),
                          ),
                        );
                      }

                      final adjustedIndex = otherIsTyping ? index - 1 : index;

                      final item = items[items.length - 1 - adjustedIndex];

                      if (item is DateSeparatorItem) {
                        return DateSeparatorWidget(label: item.label);
                      }

                      final msg = (item as MessageItem).message;
                      final isMe = msg.senderId == currentUserId;

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: isMe ? .centerRight : .centerLeft,
                          child: isMe
                              ? SentMessageWidget(
                                  userName: userData?.name ?? 'Me',
                                  message: msg,
                                  currentUserId: currentUserId,
                                )
                              : ReceivedMessageWidget(
                                  isOnline: peer?.isOnline ?? false,
                                  userName: peer?.name ?? 'Other',
                                  message: msg,
                                  currentUserId: currentUserId,
                                ),
                        ),
                      );
                    },
                  ),
                ),

                if (otherIsTyping)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TypingIndicatorWidget(
                        userName: peer?.name ?? 'Other',
                      ),
                    ),
                  ),
              ],
            ),
      bottomNavigationBar: MobileBottomInputBar(
        textNewLineOrSend: widget.textNewLineOrSend ?? true,
        controller: messageController,
        onPressedAttachment: () {
          attachFile();
        },
        onPressedEmoji: () {
          openEmojiPicker();
        },
        onPressedTextNewLine: () {},
        onPressedSend: () {
          sendMessage();
        },
      ),
    );
  }
}
