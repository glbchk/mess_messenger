import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/dropdown_item_action_model.dart';
import 'package:mess_messenger_app/core/widgets/dropdown_menu/mess_icon_dropdown_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/footer_row_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AuthMobileLayout extends ConsumerWidget {
  final Widget formContent;
  final VoidCallback onSignOutPressed;

  const AuthMobileLayout({
    super.key,
    required this.formContent,
    required this.onSignOutPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;

    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.surface0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: MessIcon(SvgIcons.logo, size: 40),
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors.surface2,
            ),
            child: IconButton(
              onPressed: () => onSignOutPressed(),
              icon: const Icon(Icons.logout, color: Colors.red),
            ),
          ),
          AppSpacing.p16.gapH,
          MessIconButton(
            SvgIcons.darkMode,
            isButtonFilled: true,
            onPressed: () {
              ref.read(authNotifierProvider.notifier).toggleThemeMode();
            },
          ),
          AppSpacing.p16.gapH,
          MessIconDropdownButton<DropdownItemAction>(
            svgAsset: SvgIcons.menuVert,
            isButtonFilled: true,
            itemLabelBuilder: (item) => item.label,
            textColorBuilder: (item) => item.textColor,
            onItemTap: (item) => item.onTap(),
            items: [
              DropdownItemAction(
                label: l10n.changeLanguage,
                onTap: () {
                  ref.read(authNotifierProvider.notifier).toggleLanguage();
                },
              ),
              DropdownItemAction(
                label: 'Contact us',
                onTap: () {}, //TODO: Need to add a contact us page
              ),
            ],
          ),
          AppSpacing.p16.gapH,
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: Center(child: formContent),
                        ),
                      ),
                      FooterWidget(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
