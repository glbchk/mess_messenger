import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/features/settings/data/models/invoice_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/widgets/settings_widgets/status_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class TableMobileWidget extends StatefulWidget {
  final String title;
  final List<InvoiceModel> invoices;
  final ValueChanged<List<InvoiceModel>>? onSelectionChanged;
  final VoidCallback? onPressedDownloadAll;
  final ValueChanged<InvoiceModel>? onPressedDownloadInvoice;
  final ValueChanged<List<InvoiceModel>>? onPressedDownloadSelected;

  const TableMobileWidget({
    super.key,
    required this.title,
    required this.invoices,
    this.onSelectionChanged,
    this.onPressedDownloadAll,
    this.onPressedDownloadInvoice,
    this.onPressedDownloadSelected,
  });

  @override
  State<TableMobileWidget> createState() => _TableMobileWidgetState();
}

class _TableMobileWidgetState extends State<TableMobileWidget> {
  late List<InvoiceModel> _invoices;

  static const double _headerHeight = 48.0;
  static const double _rowHeight = 56.0;
  static const double _tableMinWidth =
      520.0; // Minimum scrollable content width

  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _invoices = List.from(widget.invoices);
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TableMobileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.invoices != oldWidget.invoices) {
      // 🛡️ Preserve current local selections even if parent passes a new list instance
      final selectedIds = _invoices
          .where((item) => item.isSelected)
          .map((item) => item.id)
          .toSet();

      _invoices = widget.invoices.map((inv) {
        return inv.copyWith(isSelected: selectedIds.contains(inv.id));
      }).toList();
    }
  }

  bool get _isAllSelected =>
      _invoices.isNotEmpty && _invoices.every((item) => item.isSelected);

  bool get _hasSelection => _invoices.any((item) => item.isSelected);

  void _notifySelection() {
    final selected = _invoices.where((item) => item.isSelected).toList();
    widget.onSelectionChanged?.call(selected);
  }

  void _toggleSelectAll(bool? selected) {
    setState(() {
      _invoices = _invoices
          .map((item) => item.copyWith(isSelected: selected ?? false))
          .toList();
    });
    _notifySelection();
  }

  void _toggleSelectRow(int index, bool? selected) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _invoices[index] = _invoices[index].copyWith(
          isSelected: selected ?? false,
        );
      });
      _notifySelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Top Bar: Title + Download All Button
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: textTheme.headlineLarge?.copyWith(color: colors.text1),
            ),
          ],
        ),

        AppSpacing.p20.gapV,

        // 🔹 Table Structure with Pinned Checkboxes
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📍 1. PINNED LEFT COLUMN (Checkboxes)
            SizedBox(
              width: 48,
              child: Column(
                children: [
                  // Header Checkbox
                  SizedBox(
                    height: _headerHeight,
                    child: Center(
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
                  Divider(height: 1, thickness: 1, color: colors.surface4),
                  // Row Checkboxes
                  ...List.generate(_invoices.length, (index) {
                    final invoice = _invoices[index];
                    return Column(
                      children: [
                        SizedBox(
                          height: _rowHeight,
                          child: Center(
                            child: Checkbox(
                              value: invoice.isSelected,
                              onChanged: (val) => _toggleSelectRow(index, val),
                              side: BorderSide(
                                color: colors.surface4,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        if (index < _invoices.length - 1)
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: colors.surface4.withAlpha(120),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // ↔️ 2. HORIZONTALLY SWIPEABLE COLUMNS
            Expanded(
              child: Scrollbar(
                controller: _horizontalScrollController,
                thumbVisibility: true,
                trackVisibility: true,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.trackpad,
                    },
                  ),
                  child: SingleChildScrollView(
                    controller: _horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(
                        width: _tableMinWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row
                            Container(
                              height: _headerHeight,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: colors.surface4,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      'Invoice',
                                      style: textTheme.labelLarge?.copyWith(
                                        color: colors.text1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Amount',
                                      style: textTheme.labelLarge?.copyWith(
                                        color: colors.text1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Date',
                                      style: textTheme.labelLarge?.copyWith(
                                        color: colors.text1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Status',
                                      style: textTheme.labelLarge?.copyWith(
                                        color: colors.text1,
                                      ),
                                    ),
                                  ),
                                  AppSpacing.p48.gapV,
                                ],
                              ),
                            ),

                            // Data Rows
                            ...List.generate(_invoices.length, (index) {
                              final invoice = _invoices[index];
                              return Column(
                                children: [
                                  Container(
                                    height: _rowHeight,
                                    color: colors.transparent,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            invoice.title,
                                            style: textTheme.bodyLarge
                                                ?.copyWith(color: colors.text1),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            '\$ ${invoice.amount.toStringAsFixed(2)}',
                                            style: textTheme.bodyLarge
                                                ?.copyWith(color: colors.text1),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            invoice.date,
                                            style: textTheme.bodyLarge
                                                ?.copyWith(color: colors.text1),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: StatusWidget(
                                              status: invoice.status,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 48,
                                          child: IconButton(
                                            icon: MessIcon(
                                              SvgIcons.download,
                                              size: 20,
                                              color: colors.text1,
                                            ),
                                            onPressed: () => widget
                                                .onPressedDownloadInvoice
                                                ?.call(invoice),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (index < _invoices.length - 1)
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: colors.surface4.withAlpha(120),
                                    ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // Extra padding at bottom so content isn't covered by popup bar
        _hasSelection ? AppSpacing.p80.gapV : AppSpacing.p20.gapV,
      ],
    );
  }
}
