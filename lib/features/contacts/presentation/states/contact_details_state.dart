import 'package:mess_messenger_app/features/chats/data/models/chat_model.dart';

class ContactDetailsState {
  final bool isLoading;
  final String? error;
  final List<String> media;
  final List<String> links;
  final List<String> files;
  final List<ChatModel> groupsInCommon;

  const ContactDetailsState({
    this.isLoading = false,
    this.error,
    this.media = const [],
    this.links = const [],
    this.files = const [],
    this.groupsInCommon = const [],
  });

  ContactDetailsState copyWith({
    bool? isLoading,
    String? error,
    List<String>? media,
    List<String>? links,
    List<String>? files,
    List<ChatModel>? groupsInCommon,
  }) {
    return ContactDetailsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      media: media ?? this.media,
      links: links ?? this.links,
      files: files ?? this.files,
      groupsInCommon: groupsInCommon ?? this.groupsInCommon,
    );
  }
}
