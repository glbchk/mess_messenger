class ChatModel {
  final String id;
  final List<String> participantIds;
  final String lastMessage;
  final DateTime lastMessageAt;
  final bool isGroup;
  final String? groupName;
  final List<String> typingUserIds;

  ChatModel({
    required this.id,
    required this.participantIds,
    required this.lastMessage,
    required this.lastMessageAt,
    this.isGroup = false,
    this.groupName,
    this.typingUserIds = const [],
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? '',
      participantIds: List<String>.from(json['participant_ids'] ?? []),
      lastMessage: json['last_message'] ?? '',
      lastMessageAt:
          DateTime.tryParse(json['last_message_at']?.toString() ?? '') ??
          DateTime.now(),
      isGroup: json['is_group'] ?? false,
      groupName: json['group_name'],
      typingUserIds: json['typing_user_ids'] != null
          ? List<String>.from(json['typing_user_ids'] as List)
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participant_ids': participantIds,
      'last_message': lastMessage,
      'last_message_at': lastMessageAt.toIso8601String(),
      'is_group': isGroup,
      'group_name': groupName,
      'typing_user_ids': typingUserIds,
    };
  }

  ChatModel copyUserWith({
    String? id,
    List<String>? participantIds,
    String? lastMessage,
    DateTime? lastMessageAt,
    bool? isGroup,
    String? groupName,
    List<String>? typingUserIds,
  }) {
    return ChatModel(
      id: id ?? this.id,
      participantIds: participantIds ?? this.participantIds,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      isGroup: isGroup ?? this.isGroup,
      groupName: groupName ?? this.groupName,
      typingUserIds: typingUserIds ?? this.typingUserIds,
    );
  }

  List<String> otherParticipantIds(String myId) =>
      participantIds.where((id) => id != myId).toList();

  String? peerId(String myId) {
    if (isGroup) return null;
    final others = otherParticipantIds(myId);
    return others.length == 1 ? others.first : null;
  }
}
