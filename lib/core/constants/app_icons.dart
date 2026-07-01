import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/constants/icon_list.dart';

@immutable
class AppIcons extends ThemeExtension<AppIcons> {
  final String logo;
  final String chats;
  final String phone;
  final String contacts;
  final String settings;
  const AppIcons({
    required this.logo,
    required this.chats,
    required this.phone,
    required this.contacts,
    required this.settings,
  });

  /// ✅ Light preset
  factory AppIcons.light() => const AppIcons(
    logo: IconList.logoLight,
    chats: IconList.chatsLight,
    phone: IconList.phoneLight,
    contacts: IconList.contactsLight,
    settings: IconList.settingsLight,
  );

  /// ✅ Dark preset
  factory AppIcons.dark() => const AppIcons(
    logo: IconList.logoDark,
    chats: IconList.chatsDark,
    phone: IconList.phoneDark,
    contacts: IconList.contactsDark,
    settings: IconList.settingsDark,
  );
  @override
  AppIcons copyWith({
    String? logo,
    String? chats,
    String? phone,
    String? contacts,
    String? settings,
  }) {
    return AppIcons(
      logo: logo ?? this.logo,
      chats: chats ?? this.chats,
      phone: phone ?? this.phone,
      contacts: contacts ?? this.contacts,
      settings: settings ?? this.settings,
    );
  }

  @override
  AppIcons lerp(AppIcons? other, double t) {
    if (other == null) return this;
    return t < 0.5 ? this : other;
  }
}
