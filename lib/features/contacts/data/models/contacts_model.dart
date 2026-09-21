// enum ContactStatus { pending, accepted, blocked }
//
// class ContactModel {
//   final String id;
//   final List<String> userIds;
//   final ContactStatus status;
//   final String requestedBy;
//   final DateTime? createdAt;
//
//   const ContactModel({
//     required this.id,
//     required this.userIds,
//     required this.status,
//     required this.requestedBy,
//     required this.createdAt,
//   });
//
//   factory ContactModel.fromJson(Map<String, dynamic> json) {
//     return ContactModel(
//       id: json['id'],
//       userIds: json['user_ids'] != null
//           ? List<String>.from(json['user_ids'] as List)
//           : const [],
//       status: () {
//         final raw = json['status'] as String?;
//         if (raw == null) return ContactStatus.pending;
//         return ContactStatus.values.firstWhere(
//           (e) => e.name == raw || e.toString() == raw,
//           orElse: () => ContactStatus.pending,
//         );
//       }(),
//       requestedBy: json['requested_by'],
//       createdAt: json['created_at'] != null
//           ? DateTime.tryParse(json['created_at'] as String)
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_ids': userIds,
//       'status': status,
//       'requested_by': requestedBy,
//       'created_at': createdAt?.toIso8601String(),
//     };
//   }
//
//   ContactModel copyWith(
//     String? id,
//     List<String>? userIds,
//     ContactStatus? status,
//     String? requestedBy,
//     DateTime? createdAt,
//   ) {
//     return ContactModel(
//       id: id ?? this.id,
//       userIds: userIds ?? this.userIds,
//       status: status ?? this.status,
//       requestedBy: requestedBy ?? this.requestedBy,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }
