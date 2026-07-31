import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/settings/data/models/invoice_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/status_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class TableWebWidget extends StatefulWidget {
  final String title;
  final List<InvoiceModel> sampleInvoices;
  final VoidCallback? onPressedDownloadAll;
  final ValueChanged<InvoiceModel>? onPressedDownloadInvoice;
  final ValueChanged<List<InvoiceModel>>? onPressedDownloadSelected;

  const TableWebWidget({
    super.key,
    required this.title,
    required this.sampleInvoices,
    this.onPressedDownloadAll,
    this.onPressedDownloadInvoice,
    this.onPressedDownloadSelected,
  });

  @override
  State<TableWebWidget> createState() => _TableWebWidgetState();
}

class _TableWebWidgetState extends State<TableWebWidget> {
  late List<InvoiceModel> _invoices;

  @override
  void initState() {
    super.initState();
    _invoices = List.from(widget.sampleInvoices);
  }

  @override
  void didUpdateWidget(covariant TableWebWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.sampleInvoices != oldWidget.sampleInvoices) {
      // 🛡️ Preserve checkbox selections when parent rebuilds
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

    final bool isAllOrNone =
        _selectedCount == 0 || _selectedCount == _invoices.length;

    final String buttonLabel = isAllOrNone
        ? 'Download all'
        : 'Download selected';

    final VoidCallback? buttonAction = isAllOrNone
        ? widget.onPressedDownloadAll
        : () => widget.onPressedDownloadSelected?.call(_selectedInvoices);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Top Bar: Title + Download All Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
            if (_selectedInvoices.isNotEmpty)
              Row(
                spacing: 36,
                children: [
                  Text(
                    '${_selectedInvoices.length} selected',
                    style: textTheme.labelLarge?.copyWith(color: colors.text1),
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

            // MessMainButton(
            //   width: 142,
            //   height: 38,
            //   label: 'Download all',
            //   textColor: colors.text1,
            //   backgroundColor: colors.surface2,
            //   hoverColor: colors.surface4,
            //   onPressed: widget.onPressedDownloadAll,
            // ),
          ],
        ),

        AppSpacing.p20.gapV,

        // 🔹 Table Header Row
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: colors.surface4, width: 1),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Checkbox(
                  value: _isAllSelected,
                  onChanged: _toggleSelectAll,
                  side: BorderSide(color: colors.surface4, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Invoice',
                  style: textTheme.labelLarge?.copyWith(color: colors.text1),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Amount',
                  style: textTheme.labelLarge?.copyWith(color: colors.text1),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Date',
                  style: textTheme.labelLarge?.copyWith(color: colors.text1),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Status',
                  style: textTheme.labelLarge?.copyWith(color: colors.text1),
                ),
              ),
              AppSpacing.p48.gapH,
            ],
          ),
        ),

        // 🔹 Table Data Rows
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
                  SizedBox(
                    width: 48,
                    child: Checkbox(
                      value: invoice.isSelected,
                      onChanged: (val) => _toggleSelectRow(index, val),
                      side: BorderSide(color: colors.surface4, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  // Title Column
                  Expanded(
                    flex: 4,
                    child: Text(
                      invoice.title,
                      style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                    ),
                  ),
                  // Amount Column
                  Expanded(
                    flex: 2,
                    child: Text(
                      '\$ ${invoice.amount.toStringAsFixed(2)}',
                      style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                    ),
                  ),
                  // Date Column
                  Expanded(
                    flex: 2,
                    child: Text(
                      invoice.date,
                      style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                    ),
                  ),
                  // Status Pill Column
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: StatusWidget(status: invoice.status),
                    ),
                  ),
                  // Action Column
                  SizedBox(
                    width: 48,
                    child: IconButton(
                      icon: MessIcon(
                        SvgIcons.download,
                        size: 20,
                        color: colors.text1,
                      ),
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
