import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class AppBarContentWidget extends StatelessWidget {
  final Image? profileImagePath;
  final String? userName;
  final String? phoneNumber;

  const AppBarContentWidget({
    super.key,
    this.profileImagePath,
    this.userName,
    this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;

    return Row(
      children: [
        // User Avatar
        Container(
          decoration: BoxDecoration(
            color: colors.surface0,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors.border2,
                blurRadius: 0,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.blue.shade50, // Light blue background
            child: Text(
              'F',
              style: textTheme.bodyLarge?.copyWith(color: colors.text1),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // User Name and Number
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Francis Copper',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '+447903754798',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}
