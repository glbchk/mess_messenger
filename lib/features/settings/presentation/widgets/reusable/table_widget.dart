import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon_button.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/invoice_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/reusable/status_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TableWidget extends StatefulWidget {
  final List<InvoiceModel> sampleInvoices;
  final VoidCallback? onPressedDownloadAll;
  final ValueChanged<InvoiceModel>? onPressedDownloadInvoice;
  final ValueChanged<List<InvoiceModel>>? onPressedDownloadSelected;

  const TableWidget({
    super.key,
    required this.sampleInvoices,
    this.onPressedDownloadAll,
    this.onPressedDownloadInvoice,
    this.onPressedDownloadSelected,
  });

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  late List<InvoiceModel> _invoices;

  @override
  void initState() {
    super.initState();
    _invoices = List.from(widget.sampleInvoices);
  }

  @override
  void didUpdateWidget(covariant TableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.sampleInvoices != oldWidget.sampleInvoices) {
      final selectedIds = _invoices
          .where((item) => item.isSelected)
          .map((item) => item.id)
          .toSet();

      _invoices = widget.sampleInvoices.map((inv) {
        return inv.copyWith(isSelected: selectedIds.contains(inv.id));
      }).toList();
    }
  }

  List<InvoiceModel> get _selectedInvoices =>
      _invoices.where((item) => item.isSelected).toList();

  int get _selectedCount => _selectedInvoices.length;

  bool get _isAllSelected =>
      _invoices.isNotEmpty && _invoices.every((item) => item.isSelected);

  void _toggleSelectAll(bool? selected) {
    Future.microtask(() {
      if (!mounted) return;
      setState(() {
        _invoices = _invoices
            .map((item) => item.copyWith(isSelected: selected ?? false))
            .toList();
      });
    });
  }

  void _toggleSelectRow(int index, bool? selected) {
    Future.microtask(() {
      if (!mounted) return;
      setState(() {
        _invoices[index] = _invoices[index].copyWith(
          isSelected: selected ?? false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

    final l10n = context.l10n;

    final bool isAllOrNone =
        _selectedCount == 0 || _selectedCount == _invoices.length;

    final String buttonLabel = isAllOrNone
        ? l10n.downloadAllInvoices
        : l10n.downloadSelected;

    final VoidCallback? buttonAction = isAllOrNone
        ? widget.onPressedDownloadAll
        : () => widget.onPressedDownloadSelected?.call(_selectedInvoices);

    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              l10n.billingHistory,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            if (_selectedInvoices.isNotEmpty)
              Row(
                spacing: 36,
                children: [
                  if (!bp.isMobile)
                    Text(
                      '${_selectedInvoices.length} ${l10n.selected}',
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.text1,
                      ),
                    ),
                  MessMainButton(
                    width: 210,
                    height: 40,
                    label: buttonLabel,
                    backgroundColor: colors.text1,
                    textColor: colors.bg,
                    onPressed: buttonAction,
                  ),
                ],
              ),
          ],
        ),

        AppSpacing.p20.gapV,

        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: colors.surface4, width: 1),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SizedBox(
                  width: 24,
                  child: Checkbox(
                    value: _isAllSelected,
                    onChanged: _toggleSelectAll,
                    side: BorderSide(color: colors.surface4, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  l10n.invoice,
                  style: textTheme.labelLarge?.copyWith(color: colors.text1),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  l10n.amount,
                  style: textTheme.labelLarge?.copyWith(color: colors.text1),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  l10n.date,
                  style: textTheme.labelLarge?.copyWith(color: colors.text1),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  l10n.status,
                  style: textTheme.labelLarge?.copyWith(color: colors.text1),
                ),
              ),
              AppSpacing.p36.gapH,
            ],
          ),
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _invoices.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            thickness: 1,
            color: colors.surface4.withAlpha(120),
          ),
          itemBuilder: (context, index) {
            final invoice = _invoices[index];

            return Padding(
              key: ValueKey(invoice.id),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: SizedBox(
                      width: 24,
                      child: Checkbox(
                        value: invoice.isSelected,
                        onChanged: (val) => _toggleSelectRow(index, val),
                        side: BorderSide(color: colors.surface4, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      invoice.title,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '\$ ${invoice.amount.toStringAsFixed(2)}',
                      style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      invoice.date,
                      style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: .centerLeft,
                      child: StatusWidget(
                        status: invoice.status,
                      ), //TODO: Need to create different statuses
                    ),
                  ),
                  // Action Column
                  SizedBox(
                    width: 36,
                    child: MessIconButton(
                      SvgIcons.download,
                      iconSize: 20,
                      iconColor: colors.text1,
                      borderWidth: 0,
                      onPressed: () =>
                          widget.onPressedDownloadInvoice?.call(invoice),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
