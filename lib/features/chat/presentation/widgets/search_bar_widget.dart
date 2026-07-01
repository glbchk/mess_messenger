// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mess_messenger_app/core/widgets/mess_textfield.dart';
//
// class SearchBarWidget extends ConsumerWidget {
//   final String title;
//   final String iconPath;
//
//   const SearchBarWidget({
//     super.key,
//     required this.title,
//     required this.iconPath,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final colors = context.colors;
//     // final textTheme = context.textStyles;
//
//     return Container(
//       color: Colors.transparent,
//       height: 79,
//       child: MessTextField(
//         height: 56,
//         hint: 'Search here...',
//         prefixIcon: SvgPicture.asset(
//           'assets/icons/search.svg',
//           height: 24,
//           width: 24,
//         ),
//       ),
//     );
//   }
// }
