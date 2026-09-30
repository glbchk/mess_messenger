import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/constants/svg_icons.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/features/contacts/presentation/contacts_providers/contacts_providers.dart';
import 'package:mess_messenger_app/features/contacts/presentation/widgets/reusable/contact_data_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class FilesTabWidget extends ConsumerStatefulWidget {
  final String contactUserId;
  const FilesTabWidget({super.key, required this.contactUserId});

  @override
  ConsumerState<FilesTabWidget> createState() => _FilesTabWidgetState();
}

class _FilesTabWidgetState extends ConsumerState<FilesTabWidget> {
  final files = [
    'Unknown-attachment.pdf',
    'Unknown-attachment-2.pdf',
    'Resume-2024.doc',
    'Financial-sheet.csv',
  ];

  String getFileIcon(String fileName) {
    final name = fileName.toLowerCase();

    return switch (name) {
      _ when name.endsWith('.pdf') => SvgIcons.pdf,
      _ when name.endsWith('.doc') || name.endsWith('.docx') => SvgIcons.doc,
      _ when name.endsWith('.csv') => SvgIcons.csv,
      _ => SvgIcons.information,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final l10n = context.l10n;

    final files = ref.watch(
      contactDetailsProvider(widget.contactUserId).select((s) => s.files),
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Files',
              style: textTheme.titleMedium?.copyWith(color: colors.text1),
            ),
            AppSpacing.p12.gapV,

            ...List.generate(files.length, (index) {
              return ContactDataWidget(
                title: files[index],
                subtitle: 'Description',
                backgroundColor: colors.textInverse,
                iconPath: getFileIcon(files[index]),
                onPressed: () => ref
                    .read(contactDetailsProvider(widget.contactUserId).notifier)
                    .openFile(files[index]),
              );
            }),

            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
