import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/spacing/app_spacing.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class LinkPreviewTile extends StatelessWidget {
  final String url;
  final String? title;
  final String? description;
  final String? imageUrl;

  const LinkPreviewTile({
    super.key,
    required this.url,
    this.title,
    this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return InkWell(
      onTap: () {
        // TODO: Launch URL using url_launcher package
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: .center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: colors.surface4,
                borderRadius: BorderRadius.circular(16),
                image: imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(imageUrl!),
                        fit: .cover,
                      )
                    : null,
              ),
              child: imageUrl == null
                  ? const Center(child: Icon(Icons.link, size: 32))
                  : null,
            ),

            AppSpacing.p16.gapH,

            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    title ?? url,
                    style: textTheme.titleMedium?.copyWith(color: colors.text1),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  AppSpacing.p8.gapV,
                  Text(
                    description ?? 'No description available.',
                    style: textTheme.bodyMedium?.copyWith(color: colors.text2),
                    maxLines: 2,
                    overflow: .ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
