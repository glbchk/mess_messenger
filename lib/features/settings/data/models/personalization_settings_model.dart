class PersonalizationSettingsModel {
  final String? themeMode;
  final int?
  backgroundColorIndex; //TODO: Need to add a default background color boolean, when return to color setup for chats

  PersonalizationSettingsModel({this.themeMode, this.backgroundColorIndex});

  factory PersonalizationSettingsModel.defaults() {
    return PersonalizationSettingsModel(
      themeMode: 'System Default',
      backgroundColorIndex: 0,
    );
  }

  factory PersonalizationSettingsModel.fromJson(Map<String, dynamic> json) {
    return PersonalizationSettingsModel(
      themeMode: json['theme_mode'],
      backgroundColorIndex: json['background_color_index'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme_mode': themeMode,
      'background_color_index': backgroundColorIndex,
    };
  }

  PersonalizationSettingsModel copyUserWith({
    String? themeMode,
    int? backgroundColorIndex,
  }) {
    return PersonalizationSettingsModel(
      themeMode: themeMode ?? this.themeMode,
      backgroundColorIndex: backgroundColorIndex ?? this.backgroundColorIndex,
    );
  }
}
