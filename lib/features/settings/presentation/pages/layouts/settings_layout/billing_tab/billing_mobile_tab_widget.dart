import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/invoice_model.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/billing_tab/billing_desktop_tab_widget.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_widgets/subscription_plan_selector.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_widgets/table_mobile_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class BillingMobileTabWidget extends ConsumerStatefulWidget {
  final UserModel? userData;
  final ValueChanged<List<InvoiceModel>>? onDownloadInvoices;

  const BillingMobileTabWidget({
    super.key,
    this.userData,
    this.onDownloadInvoices,
  });

  @override
  ConsumerState<BillingMobileTabWidget> createState() =>
      _BillingMobileTabWidgetState();
}

class _BillingMobileTabWidgetState
    extends ConsumerState<BillingMobileTabWidget> {
  List<InvoiceModel> _selectedInvoices = const [];

  bool get _hasSelection =>
      _selectedInvoices != null && _selectedInvoices.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final selectedPlanIndex = ref.watch(selectedPlanIndexProvider);

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

    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              left: 32,
              top: 12,
              right: 32,
              bottom: _hasSelection ? 12 : 0,
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Subscription plans',
                  style: textTheme.headlineLarge?.copyWith(color: colors.text1),
                ),
                AppSpacing.p36.gapV,

                SubscriptionPlanSelector(
                  userData: widget.userData,
                  selectedPlan:
                      widget.userData?.subscriptionPlan ??
                      SubscriptionPlan.free,
                  onTapFree: () =>
                      ref.read(selectedPlanIndexProvider.notifier).state = 0,
                  onTapBasic: () =>
                      ref.read(selectedPlanIndexProvider.notifier).state = 1,
                  onTapPro: () =>
                      ref.read(selectedPlanIndexProvider.notifier).state = 2,
                ),

                AppSpacing.p32.gapV,
                TableMobileWidget(
                  title: 'Billing history',
                  invoices: sampleInvoices,
                  onSelectionChanged: (selected) {
                    setState(() {
                      _selectedInvoices = selected ?? [];
                    });
                  },
                  onPressedDownloadAll: () {
                    // Action: Download all invoices
                  },
                  onPressedDownloadInvoice: (invoice) {
                    // Action: Download single invoice
                  },
                ),
                AppSpacing.p64.gapV,
              ],
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            offset: _hasSelection ? Offset.zero : const Offset(0, 2),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _hasSelection ? 1.0 : 0.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colors.surface2,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(40),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_selectedInvoices.length} selected',
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.text1,
                      ),
                    ),
                    MessMainButton(
                      width: 210,
                      height: 40,
                      label: _selectedInvoices.length == sampleInvoices.length
                          ? 'Download all'
                          : 'Download selected',
                      backgroundColor: colors.text1,
                      textColor: colors.bg,
                      onPressed: () {
                        widget.onDownloadInvoices?.call(_selectedInvoices);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
