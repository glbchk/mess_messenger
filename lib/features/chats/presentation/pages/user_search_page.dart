import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/features/chats/chats_providers/chats_provider.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/mess_search_field.dart';
import 'package:mess_messenger_app/features/chats/presentation/widgets/reusable/search_result_tile_widget.dart';
import 'package:mess_messenger_app/features/contacts/presentation/contacts_providers/contacts_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class UserSearchPage extends ConsumerStatefulWidget {
  const UserSearchPage({super.key});

  @override
  ConsumerState<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends ConsumerState<UserSearchPage> {
  final _controller = TextEditingController();
  Timer? _debounce;

  void _onChanged(String? value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(userSearchNotifierProvider.notifier).searchByEmail(value ?? '');
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final state = ref.watch(userSearchNotifierProvider);

    final l10n = context.l10n;

    final someList = ['Sam Cook', 'Invoice 1024'];

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        backgroundColor: colors.bg,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: MessIconButton(
            SvgIcons.arrowLeft,
            isButtonFilled: true,
            borderWidth: 0,
            onPressed: () => context.pop(),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: colors.border3, height: 2.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            CustomSearchField(
              controller: _controller,
              hintText: l10n.searchFieldHint,
              onChanged: _onChanged,
              autoFocus: true,
            ),
            AppSpacing.p16.gapV,
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ...someList.map(
                    (title) => SearchResultTileWidget(
                      type: SearchResultType.recentSearch,
                      title: title,
                      contactId: '',
                      onPressed: () {},
                    ),
                  ),

                  AppSpacing.p16.gapV,

                  if (state.result != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      child: Text(
                        'CONTACT',
                        style: context.textStyles.labelMedium?.copyWith(
                          color: context.colors.text2,
                        ),
                      ),
                    ),
                    SearchResultTileWidget(
                      type: SearchResultType.contact,
                      contactId: '',
                      title: state.result?.name ?? '',
                      photoPath: '',
                      onPressed: () async {
                        final otherUserId = state.result?.id;
                        if (otherUserId == null || otherUserId.isEmpty) return;

                        final chatId = await ref
                            .read(userChatsNotifierProvider.notifier)
                            .getOrCreateChatWithUser(otherUserId);

                        if (chatId != null && context.mounted) {
                          context.push(AppRoutes.chatWith(chatId));
                        }
                      },
                    ),

                    AppSpacing.p16.gapV,
                  ],

                  if (state.result != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      child: Text(
                        'MESSAGES',
                        style: context.textStyles.labelMedium?.copyWith(
                          color: context.colors.text2,
                        ),
                      ),
                    ),
                    SearchResultTileWidget(
                      type: SearchResultType.message,
                      contactId: '',
                      title: state.result?.name ?? '',
                      photoPath: '',
                      onPressed: () {},
                    ),

                    AppSpacing.p16.gapV,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
