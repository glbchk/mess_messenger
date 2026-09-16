import 'package:flutter/material.dart';
import 'package:mess_messenger_app/core/utils/colors/palette_colors.dart';

class PersonalizationSettingsModel {
  final String? themeMode;
  final String?
  backgroundColorId; //TODO: Need to add a default background color boolean, when return to color setup for chats

  PersonalizationSettingsModel({this.themeMode, this.backgroundColorId});

  factory PersonalizationSettingsModel.defaults() {
    return PersonalizationSettingsModel(
      themeMode: ThemeMode.system.name,
      backgroundColorId: Palette.values.first.name,
    );
  }

  factory PersonalizationSettingsModel.fromJson(Map<String, dynamic> json) {
    return PersonalizationSettingsModel(
      themeMode: json['theme_mode'],
      backgroundColorId: json['background_color_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'theme_mode': themeMode, 'background_color_id': backgroundColorId};
  }

  PersonalizationSettingsModel copyUserWith({
    String? themeMode,
    String? backgroundColorId,
  }) {
    return PersonalizationSettingsModel(
      themeMode: themeMode ?? this.themeMode,
      backgroundColorId: backgroundColorId ?? this.backgroundColorId,
    );
  }
}
