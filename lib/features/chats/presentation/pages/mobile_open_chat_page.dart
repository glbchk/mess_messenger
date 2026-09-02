import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/mobile_bottom_input_bar.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class MobileOpenChatPage extends ConsumerStatefulWidget {
  final String? chatId;
  final bool? textNewLineOrSend;
  const MobileOpenChatPage({super.key, this.chatId, this.textNewLineOrSend});

  @override
  ConsumerState<MobileOpenChatPage> createState() => _OpenChatPageState();
}

class _OpenChatPageState extends ConsumerState<MobileOpenChatPage> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void attachFile() {}

  void openEmojiPicker() {}

  //Need to add action to move to the next line

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final userData = ref.read(userNotifierProvider).userData;
    if (userData == null) {
      return; // safety check — can't send without knowing who's sending
    }

    ref
        .read(chatsNotifierProvider(widget.chatId ?? '').notifier)
        .sendMessage(userData.id, text);

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final chatState = ref.watch(chatsNotifierProvider(widget.chatId ?? ''));

    if (widget.chatId?.isEmpty ?? false) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MobileAppBar(
        appBarBackgroundColor: colors.transparent,
        resizeToAvoidBottomInset: false,
        showAppBarContent: true,
        showBottomLine: true,
        onPressedBack: () => Navigator.pop(context),
        // title: 'Chats',
        actions: [
          MessIconButton(
            SvgIcons.menuVert,
            isButtonFilled: true,
            borderWidth: 0,
            onPressed: () {},
          ),
          AppSpacing.p16.gapH,
        ],
      ),

      body: chatState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                final msg = chatState.messages[index];
                final isMe = msg.senderId == 'r61Ql4fKO6WetoESjdEJeJUBe6W2';

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMe ? colors.surface2 : colors.surface4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.text, style: textTheme.bodyLarge),
                  ),
                );
              },
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
