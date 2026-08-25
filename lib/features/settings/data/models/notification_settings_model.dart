class NotificationSettingsModel {
  final bool communicationEmail;
  final bool communicationDesktop;
  final bool communicationPush;
  final bool reminderEmail;
  final bool reminderDesktop;
  final bool reminderPush;
  final bool announcementEmail;
  final bool announcementDesktop;
  final bool announcementPush;
  final bool tipsEmail;
  final bool tipsDesktop;
  final bool tipsPush;

  NotificationSettingsModel({
    required this.communicationEmail,
    required this.communicationDesktop,
    required this.communicationPush,
    required this.reminderEmail,
    required this.reminderDesktop,
    required this.reminderPush,
    required this.announcementEmail,
    required this.announcementDesktop,
    required this.announcementPush,
    required this.tipsEmail,
    required this.tipsDesktop,
    required this.tipsPush,
  });

  factory NotificationSettingsModel.defaults() {
    return NotificationSettingsModel(
      communicationEmail: true,
      communicationDesktop: true,
      communicationPush: true,
      reminderEmail: true,
      reminderDesktop: true,
      reminderPush: true,
      announcementEmail: true,
      announcementDesktop: true,
      announcementPush: true,
      tipsEmail: true,
      tipsDesktop: true,
      tipsPush: true,
    );
  }

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    return NotificationSettingsModel(
      communicationEmail: json['communication_email'] ?? true,
      communicationDesktop: json['communication_desktop'] ?? true,
      communicationPush: json['communication_push'] ?? true,
      reminderEmail: json['reminder_email'] ?? true,
      reminderDesktop: json['reminder_desktop'] ?? true,
      reminderPush: json['reminder_push'] ?? true,
      announcementEmail: json['announcement_email'] ?? true,
      announcementDesktop: json['announcement_desktop'] ?? true,
      announcementPush: json['announcement_push'] ?? true,
      tipsEmail: json['tips_email'] ?? true,
      tipsDesktop: json['tips_desktop'] ?? true,
      tipsPush: json['tips_push'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'communication_email': communicationEmail,
      'communication_desktop': communicationDesktop,
      'communication_push': communicationPush,
      'reminder_email': reminderEmail,
      'reminder_desktop': reminderDesktop,
      'reminder_push': reminderPush,
      'announcement_email': announcementEmail,
      'announcement_desktop': announcementDesktop,
      'announcement_push': announcementPush,
      'tips_email': tipsEmail,
      'tips_desktop': tipsDesktop,
      'tips_push': tipsPush,
    };
  }

  NotificationSettingsModel copyUserWith({
    bool? communicationEmail,
    bool? communicationDesktop,
    bool? communicationPush,
    bool? reminderEmail,
    bool? reminderDesktop,
    bool? reminderPush,
    bool? announcementEmail,
    bool? announcementDesktop,
    bool? announcementPush,
    bool? tipsEmail,
    bool? tipsDesktop,
    bool? tipsPush,
  }) {
    return NotificationSettingsModel(
      communicationEmail: communicationEmail ?? this.communicationEmail,
      communicationDesktop: communicationDesktop ?? this.communicationDesktop,
      communicationPush: communicationPush ?? this.communicationPush,
      reminderEmail: reminderEmail ?? this.reminderEmail,
      reminderDesktop: reminderDesktop ?? this.reminderDesktop,
      reminderPush: reminderPush ?? this.reminderPush,
      announcementEmail: announcementEmail ?? this.announcementEmail,
      announcementDesktop: announcementDesktop ?? this.announcementDesktop,
      announcementPush: announcementPush ?? this.announcementPush,
      tipsEmail: tipsEmail ?? this.tipsEmail,
      tipsDesktop: tipsDesktop ?? this.tipsDesktop,
      tipsPush: tipsPush ?? this.tipsPush,
    );
  }
}
