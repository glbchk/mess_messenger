import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MediaTabWidget extends ConsumerStatefulWidget {
  final String contactUserId;
  const MediaTabWidget({super.key, required this.contactUserId});

  @override
  ConsumerState<MediaTabWidget> createState() => _MediaTabWidgetState();
}

class _MediaTabWidgetState extends ConsumerState<MediaTabWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    final bp = ResponsiveBreakpoints.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 12, right: 32),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: bp.isMobile
                  ? const EdgeInsets.only(right: 110.0)
                  : EdgeInsets.zero,
              child: GridView.count(
                crossAxisCount: bp.isMobile ? 1 : 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(mockedPhotos.length, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: .hardEdge,
                    child: Image.asset(mockedPhotos[index], fit: BoxFit.cover),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final mockedPhotos = [
  'assets/images/user_images/Avatar image-1.png',
  'assets/images/user_images/Avatar image-2.png',
  'assets/images/user_images/Avatar image-3.png',
  'assets/images/user_images/Avatar image-4.png',
  'assets/images/user_images/Avatar image-5.png',
  'assets/images/user_images/Avatar image-6.png',
];
