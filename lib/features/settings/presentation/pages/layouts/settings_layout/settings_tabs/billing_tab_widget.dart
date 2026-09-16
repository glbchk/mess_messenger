import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/mocked_data/mocked_data_constants.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/table_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_widgets/subscription_plan_selector.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BillingTabWidget extends ConsumerStatefulWidget {
  const BillingTabWidget({super.key});

  @override
  ConsumerState<BillingTabWidget> createState() => _BillingTabWidgetState();
}

class _BillingTabWidgetState extends ConsumerState<BillingTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final double columnWidth = 320;

    final bp = ResponsiveBreakpoints.of(context);

    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              l10n.subscriptionPlans,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p36.gapV,

            SubscriptionPlanSelector(),

            AppSpacing.p32.gapV,
            TableWidget(
              sampleInvoices: sampleInvoices,
              onPressedDownloadAll: () {
                // Downloads all sampleInvoices
              },
              onPressedDownloadSelected: (selectedInvoices) {
                // Downloads only selectedInvoices
              },
              onPressedDownloadInvoice: (invoice) {
                // Downloads individual invoice
              },
            ),
            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
