import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/features/settings/data/models/invoice_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/subscription_plan_selector.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/table_web_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

final selectedPlanIndexProvider = StateProvider<int>((ref) => 0);

class BillingDesktopTabWidget extends ConsumerStatefulWidget {
  final UserModel? userData;

  const BillingDesktopTabWidget({super.key, this.userData});

  @override
  ConsumerState<BillingDesktopTabWidget> createState() =>
      _BillingDesktopTabWidgetState();
}

class _BillingDesktopTabWidgetState
    extends ConsumerState<BillingDesktopTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final double columnWidth = 320;

    final selectedPlanIndex = ref.watch(selectedPlanIndexProvider);

    final bp = ResponsiveBreakpoints.of(context);

    final sampleInvoices = [
      const InvoiceModel(
        id: '1',
        title: 'Basic Plan – Dec 2023',
        amount: 10.00,
        date: 'Dec 1, 2023',
        status: InvoiceStatus.awaiting,
      ),
      const InvoiceModel(
        id: '2',
        title: 'Basic Plan – Nov 2023',
        amount: 10.00,
        date: 'Nov 1, 2023',
        status: InvoiceStatus.paid,
      ),
      const InvoiceModel(
        id: '3',
        title: 'Basic Plan – Nov 2023',
        amount: 10.00,
        date: 'Nov 1, 2023',
        status: InvoiceStatus.paid,
      ),
      const InvoiceModel(
        id: '4',
        title: 'Basic Plan – Nov 2023',
        amount: 10.00,
        date: 'Nov 1, 2023',
        status: InvoiceStatus.paid,
      ),
      const InvoiceModel(
        id: '5',
        title: 'Basic Plan – Nov 2023',
        amount: 10.00,
        date: 'Nov 1, 2023',
        status: InvoiceStatus.paid,
      ),
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subscription plans',
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            AppSpacing.p36.gapV,

            SubscriptionPlanSelector(
              selectedPlanIndex: selectedPlanIndex,
              onTapFree: () =>
                  ref.read(selectedPlanIndexProvider.notifier).state = 0,
              onTapBasic: () =>
                  ref.read(selectedPlanIndexProvider.notifier).state = 1,
              onTapPro: () =>
                  ref.read(selectedPlanIndexProvider.notifier).state = 2,
            ),

            AppSpacing.p32.gapV,
            TableWebWidget(
              title: 'Billing history',
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
