import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/widgets/mess_icon.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DatePickerDropdownWidget extends StatefulWidget {
  final MenuController menuController;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final String hintText;
  final Color? accentColor;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final double? menuWidth;
  final String? error;
  final Color? errorColor;

  const DatePickerDropdownWidget({
    super.key,
    required this.menuController,
    this.selectedDate,
    required this.onDateSelected,
    this.hintText = 'Add a birthday! (Optional)',
    this.accentColor,
    this.firstDate,
    this.lastDate,
    this.menuWidth,
    this.error,
    this.errorColor,
  });

  @override
  State<DatePickerDropdownWidget> createState() =>
      _DatePickerDropdownWidgetState();
}

class _DatePickerDropdownWidgetState extends State<DatePickerDropdownWidget> {
  // final MenuController _menuController = MenuController();

  String _formatDate(DateTime date) {
    // Simple string formatting (e.g., 2026-08-05).
    // Replace with `DateFormat('MMM dd, yyyy').format(date)` if using package:intl
    return DateFormat.yMMMMd().format(date);
    // return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final activeAccent = widget.accentColor ?? colors.text1;
    final bp = ResponsiveBreakpoints.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Actual space this widget has, after any parent padding —
        // no magic numbers needed.
        final double availableWidth = constraints.maxWidth;

        // Use ResponsiveBreakpoints only for the *ratio*, not the raw width.
        final double widthFactor = bp.isMobile
            ? 1.0
            : bp.isTablet
            ? 0.6
            : 0.4;

        final double menuWidth =
            widget.menuWidth ?? availableWidth * widthFactor;

        return Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: menuWidth,
            child: MenuAnchor(
              controller: widget.menuController,
              alignmentOffset: const Offset(0, 8),
              style: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(colors.bg),
                surfaceTintColor: WidgetStatePropertyAll(colors.transparent),
                elevation: const WidgetStatePropertyAll(12),
                shadowColor: WidgetStatePropertyAll(
                  colors.shadowColor.withValues(alpha: 0.5),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                minimumSize: WidgetStatePropertyAll(Size(menuWidth, 0)),
                maximumSize: WidgetStatePropertyAll(Size(menuWidth, 380)),
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
              ),
              menuChildren: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: menuWidth,
                    height: 360,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: activeAccent,
                          onPrimary: colors.bg,
                        ),
                      ),
                      child: CalendarDatePicker(
                        initialDate: widget.selectedDate ?? DateTime.now(),
                        firstDate: widget.firstDate ?? DateTime(2000),
                        lastDate: widget.lastDate ?? DateTime(2100),
                        onDateChanged: (DateTime newDate) {
                          widget.onDateSelected(newDate);
                          widget.menuController.close();
                        },
                      ),
                    ),
                  ),
                ),
              ],
              builder: (context, localController, child) {
                final isOpen = localController.isOpen;
                final hasValue = widget.selectedDate != null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: menuWidth,
                      decoration: BoxDecoration(
                        color: isOpen ? colors.bg : colors.surface2,
                        border: Border.all(
                          color: isOpen ? colors.border2 : colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Material(
                        color: colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          hoverColor: colors.surface4,
                          splashColor: colors.surface2,
                          onTap: () => isOpen
                              ? localController.close()
                              : localController.open(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                MessIcon(
                                  SvgIcons.calendar,
                                  color: colors.text1,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    hasValue
                                        ? _formatDate(widget.selectedDate!)
                                        : widget.hintText,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.labelLarge?.copyWith(
                                      color: colors.text1,
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                                MessIcon(
                                  isOpen
                                      ? SvgIcons.chevronUp
                                      : SvgIcons.chevronDown,
                                  color: colors.text1,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.error?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          widget.error ?? '',
                          style: textTheme.bodySmall?.copyWith(
                            color: widget.errorColor ?? colors.errorColor,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
