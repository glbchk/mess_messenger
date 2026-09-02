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
      isLoggedIn: json['is_logged_in'] ?? false,
      language: json['language'] ?? '',
      isPhotoPasswordProtected: json['is_photo_password_protected'] ?? false,
      isAudioPasswordProtected: json['is_audio_password_protected'] ?? false,
      isVideoPasswordProtected: json['is_video_password_protected'] ?? false,
      isDocumentPasswordProtected:
          json['is_document_password_protected'] ?? false,
      messages: json['messages'] != null
          ? List<MessageModel>.from(
              json['messages'].map((m) => MessageModel.fromJson(m)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_logged_in': isLoggedIn,
      'language': language,
      'is_photo_password_protected': isPhotoPasswordProtected,
      'is_audio_password_protected': isAudioPasswordProtected,
      'is_video_password_protected': isVideoPasswordProtected,
      'is_document_password_protected': isDocumentPasswordProtected,
      'messages': messages?.map((m) => m.toJson()).toList(),
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
