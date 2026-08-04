import 'package:mess_messenger_app/features/chats/data/models/message_model.dart';

class GeneralSettingsModel {
  final bool? isLoggedIn;
  final String? language;
  final bool? isPhotoPasswordProtected;
  final bool? isAudioPasswordProtected;
  final bool? isVideoPasswordProtected;
  final bool? isDocumentPasswordProtected;
  final List<MessageModel>? messages;

  GeneralSettingsModel({
    this.isLoggedIn,
    this.language,
    this.isPhotoPasswordProtected,
    this.isAudioPasswordProtected,
    this.isVideoPasswordProtected,
    this.isDocumentPasswordProtected,
    this.messages,
  });

  factory GeneralSettingsModel.defaults() {
    return GeneralSettingsModel(
      isLoggedIn: true,
      language: null,
      isPhotoPasswordProtected: false,
      isAudioPasswordProtected: false,
      isVideoPasswordProtected: false,
      isDocumentPasswordProtected: false,
      messages: [],
    );
  }

  factory GeneralSettingsModel.fromJson(Map<String, dynamic> json) {
    return GeneralSettingsModel(
      isLoggedIn: json['general_settings.is_logged_in'] ?? false,
      language: json['general_settings.general_settings.language'] ?? '',
      isPhotoPasswordProtected:
          json['general_settings.is_photo_password_protected'] ?? false,
      isAudioPasswordProtected:
          json['general_settings.is_audio_password_protected'] ?? false,
      isVideoPasswordProtected:
          json['general_settings.is_video_password_protected'] ?? false,
      isDocumentPasswordProtected:
          json['general_settings.is_document_password_protected'] ?? false,
      messages: json['general_settings.messages'] != null
          ? List<MessageModel>.from(
              json['general_settings.messages'].map(
                (m) => MessageModel.fromJson(m),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'general_settings.is_logged_in': isLoggedIn,
      'general_settings.language': language,
      'general_settings.is_photo_password_protected': isPhotoPasswordProtected,
      'general_settings.is_audio_password_protected': isAudioPasswordProtected,
      'general_settings.is_video_password_protected': isVideoPasswordProtected,
      'general_settings.is_document_password_protected':
          isDocumentPasswordProtected,
      'general_settings.messages': messages?.map((m) => m.toJson()).toList(),
    };
  }

  GeneralSettingsModel copyUserWith({
    bool? isLoggedIn,
    String? Function()? language,
    bool? isPhotoPasswordProtected,
    bool? isAudioPasswordProtected,
    bool? isVideoPasswordProtected,
    bool? isDocumentPasswordProtected,
    List<MessageModel>? messages,
  }) {
    return GeneralSettingsModel(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      language: language != null ? language() : this.language,
      isPhotoPasswordProtected:
          isPhotoPasswordProtected ?? this.isPhotoPasswordProtected,
      isAudioPasswordProtected:
          isAudioPasswordProtected ?? this.isAudioPasswordProtected,
      isVideoPasswordProtected:
          isVideoPasswordProtected ?? this.isVideoPasswordProtected,
      isDocumentPasswordProtected:
          isDocumentPasswordProtected ?? this.isDocumentPasswordProtected,
      messages: messages ?? this.messages,
    );
  }
}
