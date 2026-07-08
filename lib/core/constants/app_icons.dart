// import 'package:flutter/material.dart';
// import 'package:mess_messenger_app/core/constants/svg_icons.dart';
//
// @immutable
// abstract final class SvgIcons {
//   final String logo;
//   final String chats;
//   final String phone;
//   final String contacts;
//   final String settings;
//   const SvgIcons({
//     required this.logo,
//     required this.chats,
//     required this.phone,
//     required this.contacts,
//     required this.settings,
//   });
//
//   /// ✅ Light preset
//   factory SvgIcons.light() => const SvgIcons(
//     logo: SvgIconss.logoLight,
//     chats: SvgIconss.chatsLight,
//     phone: SvgIconss.phoneLight,
//     contacts: SvgIconss.contactsLight,
//     settings: SvgIconss.settingsLight,
//   );
//
//   /// ✅ Dark preset
//   factory SvgIcons.dark() => const SvgIcons(
//     logo: SvgIconss.logoDark,
//     chats: SvgIconss.chatsDark,
//     phone: SvgIconss.phoneDark,
//     contacts: SvgIconss.contactsDark,
//     settings: SvgIconss.settingsDark,
//   );
//   @override
//   SvgIcons copyWith({
//     String? logo,
//     String? chats,
//     String? phone,
//     String? contacts,
//     String? settings,
//   }) {
//     return SvgIcons(
//       logo: logo ?? this.logo,
//       chats: chats ?? this.chats,
//       phone: phone ?? this.phone,
//       contacts: contacts ?? this.contacts,
//       settings: settings ?? this.settings,
//     );
//   }
//
//   @override
//   SvgIcons lerp(SvgIcons? other, double t) {
//     if (other == null) return this;
//     return t < 0.5 ? this : other;
//   }
// }
