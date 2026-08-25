import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/support_faq_list.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/spacing_modifier.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/core/widgets/web_widgets/web_input_bar.dart';
import 'package:mess_messenger_app/features/settings/data/models/chat_message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/simple_header_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/support_faq_chat_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

enum _FaqVisibility { open, collapsed, hidden }

class SupportChatPanelWidget extends ConsumerStatefulWidget {
  final UserModel userData;
  final List<ChatMessage> messages;
  final ScrollController scrollController;
  final TextEditingController controller;
  final VoidCallback onPressedAttachment;
  final VoidCallback onPressedEmoji;
  final VoidCallback onPressedTextNewLine;
  final VoidCallback onPressedSend;
  final ValueChanged<SupportFaqItem> onSelectQuestion;
  final bool? textNewLineOrSend;
  final VoidCallback? onBackButtonPressed;
  final VoidCallback? onPressedShowDetails;
  final VoidCallback? onPressedRequestAgent;
  final bool isReadOnly;
  final VoidCallback? onPressedExitReadOnly;

  const SupportChatPanelWidget({
    super.key,
    required this.userData,
    required this.messages,
    required this.scrollController,
    required this.controller,
    required this.onPressedAttachment,
    required this.onPressedEmoji,
    required this.onPressedTextNewLine,
    required this.onPressedSend,
    required this.onSelectQuestion,
    this.textNewLineOrSend,
    this.onBackButtonPressed,
    this.onPressedShowDetails,
    this.onPressedRequestAgent,
    this.isReadOnly = false,
    this.onPressedExitReadOnly,
  });

  @override
  ConsumerState<SupportChatPanelWidget> createState() =>
      _SupportChatDetailPanelState();
}

class _SupportChatDetailPanelState
    extends ConsumerState<SupportChatPanelWidget> {
  _FaqVisibility _faqVisibility = _FaqVisibility.open;

  void _handleFaqSelected(SupportFaqItem item) {
    widget.onSelectQuestion(item);
    setState(() => _faqVisibility = _FaqVisibility.collapsed);
  }

  void _showFaq() {
    setState(() => _faqVisibility = _FaqVisibility.open);
  }

  @override
  void didUpdateWidget(covariant SupportChatPanelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isReadOnly != oldWidget.isReadOnly) {
      setState(() => _faqVisibility = _FaqVisibility.open);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.scrollController.hasClients) return;
      widget.scrollController.animateTo(
        0, // was: _scrollController.position.maxScrollExtent
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  // void _toggleFaqPanel() => setState(() => _showFaqPanel = !_showFaqPanel);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Stack(
      children: [
        Column(
          children: [
            SimpleHeaderWidget(
              showBackButton: true,
              onBackButtonPressed: widget.onBackButtonPressed,
              userData: widget.userData,
              onPressed: () {},
              onPressedShowDetails: widget.onPressedShowDetails,
            ),
            Expanded(
              child: ListView.builder(
                controller: widget.scrollController,
                reverse: true,
                padding: const EdgeInsets.all(16),
                itemCount: widget.messages.length,
                itemBuilder: (context, index) {
                  final msg =
                      widget.messages[widget.messages.length - 1 - index];
                  final isMe = msg.isUser;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Align(
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
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: widget.isReadOnly
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 24,
                      children: [
                        Text(
                          'Viewing a past request',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.text2,
                          ),
                        ),
                        MessMainButton(
                          label: 'Close chat',
                          width: 160,
                          onPressed: widget.onPressedExitReadOnly,
                        ),
                      ],
                    )
                  : WebInputBar(
                      textNewLineOrSend: widget.textNewLineOrSend ?? true,
                      controller: widget.controller,
                      onPressedAttachment: widget.onPressedAttachment,
                      onPressedEmoji: widget.onPressedEmoji,
                      onPressedTextNewLine: widget.onPressedTextNewLine,
                      onPressedSend: widget.onPressedSend,
                      onPressedFAQ: _showFaq,
                    ),
            ),
          ],
        ),
        if (!widget.isReadOnly && _faqVisibility == _FaqVisibility.open)
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SupportFaqPanel(
                  items: supportFaqList,
                  onSelectQuestion: _handleFaqSelected,
                  onClose: () =>
                      setState(() => _faqVisibility = _FaqVisibility.collapsed),
                ),
              ),
            ),
          )
        else if (!widget.isReadOnly &&
            _faqVisibility == _FaqVisibility.collapsed)
          Positioned(
            bottom: 100,
            left: 380,
            right: 380,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                spacing: 12,
                children: [
                  MessMainButton(
                    label: 'Open FAQ panel',
                    width: 200,
                    textColor: colors.text1,
                    backgroundColor: colors.bg,
                    buttonShadow: colors.text1,
                    onPressed: () =>
                        setState(() => _faqVisibility = _FaqVisibility.open),
                  ),
                  MessMainButton(
                    label: 'Request an agent',
                    width: 200,
                    textColor: colors.text1,
                    backgroundColor: colors.bg,
                    buttonShadow: colors.text1,
                    onPressed: widget.onPressedRequestAgent ?? () {},
                  ),
                  MessIconButton(
                    SvgIcons.close,
                    onPressed: () =>
                        setState(() => _faqVisibility = _FaqVisibility.hidden),
                  ),
                ],
              ),
            ),
          )
        else
          SpacingModifier.empty(),
      ],
    );
  }
}
