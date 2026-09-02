import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/support_faq_list.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/app_bar/mobile_app_bar.dart';
import 'package:mess_messenger_app/core/widgets/mobile_widgets/mobile_bottom_input_bar.dart';
import 'package:mess_messenger_app/features/settings/data/models/chat_message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/support_widgets/details_content_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/support_widgets/details_panel_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/support_widgets/support_chat_section_widget.dart';
import 'package:mess_messenger_app/localization/l10n/app_localizations.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class SupportMobileLayout extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final UserModel userData;
  final List<SupportRequest> pastRequests;
  final TextEditingController messageController;
  final VoidCallback onSendMessage;
  final List<ChatMessage> messages;
  final ScrollController scrollController;
  final void Function(SupportFaqItem item) onSelectQuestion;
  final VoidCallback? onPressedRequestAgent;
  final ValueChanged<SupportRequest>? onSelectPastRequest;
  final bool isReadOnly;
  final VoidCallback? onPressedExitReadOnly;
  final bool? textNewLineOrSend;

  const SupportMobileLayout({
    super.key,
    required this.l10n,
    required this.userData,
    required this.pastRequests,
    required this.messageController,
    required this.onSendMessage,
    required this.messages,
    required this.scrollController,
    required this.onSelectQuestion,
    this.onPressedRequestAgent,
    this.onSelectPastRequest,
    this.isReadOnly = false,
    this.onPressedExitReadOnly,
    this.textNewLineOrSend,
  });

  @override
  ConsumerState<SupportMobileLayout> createState() =>
      _SupportMobileLayoutState();
}

class _SupportMobileLayoutState extends ConsumerState<SupportMobileLayout> {
  final TextEditingController messageController = TextEditingController();
  bool isDetailsOpened = true;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // final textTheme = context.textStyles;

    final sectionWidth = double.infinity;

    void _showDetails() {
      setState(() => isDetailsOpened = false);
    }

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: MobileAppBar(
        appBarBackgroundColor: colors.transparent,
        resizeToAvoidBottomInset: false,
        showAppBarContent: true,
        showBottomLine: true,
        onPressedBack: () => context.pop(),
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

      body: !isDetailsOpened
          ? Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: colors.bg,
                ),
                child: SupportChatPanelWidget(
                  userData: widget.userData,
                  controller: widget.messageController,
                  onPressedAttachment: () {},
                  onPressedEmoji: () {},
                  onPressedTextNewLine: () {},
                  onPressedSend: widget.onSendMessage,
                  messages: widget.messages,
                  scrollController: widget.scrollController,
                  onSelectQuestion: widget.onSelectQuestion,
                  onBackButtonPressed: () => _showDetails(),
                  onPressedShowDetails: () =>
                      setState(() => isDetailsOpened = true),
                  onPressedRequestAgent: widget.onPressedRequestAgent,
                  isReadOnly: widget.isReadOnly,
                  onPressedExitReadOnly: widget.onPressedExitReadOnly,
                ),
              ),
            )
          : Expanded(
              child: DetailsPanelWidget(
                userData: widget.userData,
                sectionWidth: sectionWidth,
                pastRequests: widget.pastRequests,
                onSelectPastRequest: widget.onSelectPastRequest,
                onPressedClose: () => setState(() => isDetailsOpened = false),
              ),
            ),

      bottomNavigationBar: MobileBottomInputBar(
        textNewLineOrSend: widget.textNewLineOrSend ?? true,
        controller: messageController,
        onPressedAttachment: () {
          // attachFile();
        },
        onPressedEmoji: () {
          // openEmojiPicker();
        },
        onPressedTextNewLine: () {},
        onPressedSend: () {
          // sendMessage();
        },
      ),
    );
  }
}
