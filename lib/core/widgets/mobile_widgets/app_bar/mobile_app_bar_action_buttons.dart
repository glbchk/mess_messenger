import 'package:flutter/material.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

List<Widget> buildMobileAppBarActionButtons(
  BuildContext context,
  bool options,
) {
  final colors = context.colors;
  final textTheme = context.textStyles;

  return options
      ? [
          IconButton(
            icon: Icon(Icons.search, color: colors.icon1),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
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
                backgroundColor: colors.surface2,
                child: Text(
                  'S',
                  style: textTheme.bodyLarge?.copyWith(color: colors.text1),
                ),
              ),
            ),
          ),
        ]
      : [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.more_vert, color: colors.icon1),
              onPressed: () {},
            ),
          ),
        ];
}

// class ActionButtonsAppBar extends StatelessWidget {
//   final bool options;
//
//   const ActionButtonsAppBar({super.key, required this.options});
//
//   @override
//   Widget build(BuildContext context) {
//     final colors = context.colors;
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: options
//           ? [
//               IconButton(
//                 icon: Icon(Icons.add, color: colors.icon1),
//                 onPressed: () {},
//               ),
//               CircleAvatar(
//                 backgroundColor: Colors.blue.shade50,
//                 child: const Text(
//                   'S',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ]
//           : [
//               IconButton(
//                 icon: Icon(Icons.more_vert, color: colors.icon1),
//                 onPressed: () {},
//               ),
//             ],
//     );
//   }
// }
