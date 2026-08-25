import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/support_faq_list.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/open_chat_provider.dart';
import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/chat_message_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/support_chat_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/support_layouts/support_desktop_layout.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/support_layouts/support_mobile_layout.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/support_layouts/support_tablet_layout.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/details_content_widget.dart';
import 'package:mess_messenger_app/features/settings/user_providers/support_chat_providers.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SupportPage extends ConsumerStatefulWidget {
  const SupportPage({super.key});

  @override
  ConsumerState<SupportPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SupportPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final TextEditingController _inputController;

  late final TabController tabController;

  late final TextEditingController nameController;
  late final MenuController birthdayController;
  DateTime? _selectedDate;
  late final TextEditingController emailController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;

  final List<ChatMessage> _messages = [];
  final List<SupportRequest> _pastRequests = [];
  late final ScrollController _scrollController;

  String? _supportChatId;
  SupportRequest? _viewedPastRequest;

  Future<void> _initSupportChat() async {
    final currentUserId = ref.read(userNotifierProvider).userData?.id;
    if (currentUserId == null) return;
    final chatId = await ref
        .read(getOrCreateChatUseCaseProvider)
        .execute(currentUserId, kFaqBotSenderId);
    if (!mounted) return;
    setState(() => _supportChatId = chatId);
  }

  void _selectFaqQuestion(SupportFaqItem item) {
    setState(() {
      _messages.add(ChatMessage(text: item.question, isUser: true));
      _messages.add(ChatMessage(text: item.answer, isUser: false));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _requestAgent() async {
    await ref.read(supportChatNotifierProvider.notifier).requestAgent();
  }

  void _viewPastRequest(SupportRequest request) =>
      setState(() => _viewedPastRequest = request);
  void _closePastRequestView() => setState(() => _viewedPastRequest = null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 6, vsync: this);
    _inputController = TextEditingController();
    _scrollController = ScrollController();

    final currentUserData = ref.read(userNotifierProvider).userData;

    nameController = TextEditingController(text: currentUserData?.name ?? '');
    birthdayController = MenuController();
    emailController = TextEditingController(text: currentUserData?.email ?? '');
    phoneNumberController = TextEditingController(
      text: currentUserData?.phoneNumber ?? '',
    );
    newPasswordController = TextEditingController();
    currentPasswordController = TextEditingController();

    final savedBirthday = currentUserData?.birthday;
    if (savedBirthday != null && savedBirthday.isNotEmpty) {
      _selectedDate = DateTime.tryParse(savedBirthday);
    }

    _initSupportChat();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inputController.dispose();
    _scrollController.dispose();
    tabController.dispose();
    nameController.dispose();
    birthdayController.close();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(userNotifierProvider.notifier).checkEmailVerificationStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');
    final pastAgentRequests =
        ref.watch(pastSupportRequestsProvider).value ?? [];
    final agentRequestRows = pastAgentRequests
        .map(
          (r) => SupportRequest(
            id: r.id,
            date: r.updatedAt.toIso8601String(),
            question: 'Support agent conversation',
            answer: r.status == SupportChatStatus.closed
                ? 'Resolved'
                : 'In progress',
          ),
        )
        .toList();
    final allPastRequests = [..._pastRequests, ...agentRequestRows];

    final bp = ResponsiveBreakpoints.of(context);

    ref.listen(userNotifierProvider, (previous, next) {
      final newName = next.userData?.name ?? '';
      if (nameController.text != newName) {
        nameController.text = newName;
      }
    });

    ref.listen(userNotifierProvider, (previous, next) {
      final newBirthday = next.userData?.birthday ?? '';
      if (_selectedDate != DateTime.tryParse(newBirthday)) {
        _selectedDate = DateTime.tryParse(newBirthday);
      }
    });

    void _sendMessage() {
      final text = _inputController.text.trim();
      if (text.isEmpty) return;
      setState(() {
        _messages.add(ChatMessage(text: text, isUser: true));
        final match = findMatchingFaq(text);
        _messages.add(
          ChatMessage(
            text:
                match?.answer ??
                "I couldn't find an answer to that. You can reach our support "
                    "team directly at support@yourapp.com and we'll get back to you.",
            isUser: false,
          ),
        );
      });
      _inputController.clear();
      _scrollToBottom();
    }

    final supportChatState = ref.watch(supportChatNotifierProvider);
    final isEscalated = supportChatState.status != SupportChatStatus.bot;

    final viewedRequestId = _viewedPastRequest?.id;
    final isViewingPastRequest = viewedRequestId != null;
    final viewedMessages = viewedRequestId != null
        ? ref
                  .watch(viewedSupportRequestMessagesProvider(viewedRequestId))
                  .value ??
              const <MessageModel>[]
        : const <MessageModel>[];

    final displayMessages = isViewingPastRequest
        ? viewedMessages
              .map(
                (m) => ChatMessage(
                  text: m.text,
                  isUser: m.senderId == userData.id,
                ),
              )
              .toList()
        : isEscalated
        ? supportChatState.messages
              .map(
                (m) => ChatMessage(
                  text: m.text,
                  isUser: m.senderId == userData.id,
                ),
              )
              .toList()
        : _messages;

    void handleSend() {
      if (isEscalated) {
        ref
            .read(supportChatNotifierProvider.notifier)
            .sendMessage(_inputController.text);
        _inputController.clear();
      } else {
        _sendMessage();
      }
    }

    Future<void> openChattingPage() async {}

    return ResponsiveLayout(
      mobile: SupportMobileLayout(
        l10n: l10n,
        userData: userData,
        pastRequests: allPastRequests,
        messageController: _inputController,
        messages: displayMessages,
        scrollController: _scrollController,
        onSelectQuestion: _selectFaqQuestion,
        onSendMessage: handleSend,
        isReadOnly: isViewingPastRequest,
        onPressedExitReadOnly: _closePastRequestView,
        onSelectPastRequest: _viewPastRequest,
        onPressedRequestAgent: (isEscalated || isViewingPastRequest)
            ? null
            : _requestAgent,
      ),
      tablet: SupportTabletLayout(
        l10n: l10n,
        userData: userData,
        pastRequests: allPastRequests,
        messageController: _inputController,
        messages: displayMessages,
        scrollController: _scrollController,
        onSelectQuestion: _selectFaqQuestion,
        onSendMessage: handleSend,
        isReadOnly: isViewingPastRequest,
        onPressedExitReadOnly: _closePastRequestView,
        onSelectPastRequest: _viewPastRequest,
        onPressedRequestAgent: (isEscalated || isViewingPastRequest)
            ? null
            : _requestAgent,
      ),
      desktop: SupportDesktopLayout(
        l10n: l10n,
        userData: userData,
        pastRequests: allPastRequests,
        messageController: _inputController,
        messages: displayMessages,
        scrollController: _scrollController,
        onSelectQuestion: _selectFaqQuestion,
        onSendMessage: handleSend,
        isReadOnly: isViewingPastRequest,
        onPressedExitReadOnly: _closePastRequestView,
        onSelectPastRequest: _viewPastRequest,
        onPressedRequestAgent: (isEscalated || isViewingPastRequest)
            ? null
            : _requestAgent,
      ),
    );
  }
}
