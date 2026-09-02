enum SupportChatStatus { bot, agentRequested, withAgent, closed }

class SupportChatModel {
  final String id;
  final String userId;
  final SupportChatStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  SupportChatModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupportChatModel.fromJson(Map<String, dynamic> json) {
    return SupportChatModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      status: SupportChatStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => SupportChatStatus.bot,
      ),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
