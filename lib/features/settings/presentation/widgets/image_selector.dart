import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ImageSelector extends StatefulWidget {
  final Uint8List? imageBytes;

  const ImageSelector({super.key, this.imageBytes});

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final imageBytes = widget.imageBytes;

    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: colors.componentSpecific,
            shape: BoxShape.circle,
            image: imageBytes != null
                ? DecorationImage(
                    image: MemoryImage(imageBytes),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: widget.imageBytes == null
              ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
              : null,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
