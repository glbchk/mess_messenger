import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/providers/data_providers/metadata_provider.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/features/contacts/presentation/pages/contacts_tabs/metadata_fetch/link_preview_tile_widget.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class LinksTabWidget extends ConsumerStatefulWidget {
  final String contactUserId;
  const LinksTabWidget({super.key, required this.contactUserId});

  @override
  ConsumerState<LinksTabWidget> createState() => _LinksTabWidgetState();
}

class _LinksTabWidgetState extends ConsumerState<LinksTabWidget> {
  final List<String> _urls = [
    'https://www.aircanada.com/home/ca/en/aco/flights',
    'https://www.kiwi.com/en/search/results/madrid-spain,lisbon-portugal/sao-luis-state-of-maranhao-brazil/2026-12-01_2026-12-20/no-return/?bags=0.1-',
    'https://www.instagram.com/',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Links',
              style: textTheme.titleMedium?.copyWith(color: colors.text1),
            ),
            AppSpacing.p12.gapV,

            ..._urls.map((url) {
              return Consumer(
                builder: (context, ref, _) {
                  final metadata = ref.watch(linkMetadataProvider(url));
                  return metadata.when(
                    loading: () => const SizedBox(
                      height: 96,
                      child: Center(child: CircularProgressIndicator()),
                    ),

                    error: (_, _) => LinkPreviewTile(url: url),
                    data: (data) => LinkPreviewTile(
                      url: url,
                      title: data?.title,
                      description: data?.description,
                      imageUrl: data?.image,
                    ),
                  );
                },
              );
            }),

            AppSpacing.p64.gapV,
          ],
        ),
      ),
    );
  }
}
