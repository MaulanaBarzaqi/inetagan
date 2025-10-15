import 'package:inetagan/features/notifications/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.dataPayload,
    required super.receivedAt,
    super.isRead,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'dataPayload': dataPayload,
    'receivedAt': receivedAt.toIso8601String(),
    'isRead': isRead,
  };

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String?,
      body: json['body'] as String?,
      dataPayload: json['dataPayload'] as Map<String, dynamic>,
      receivedAt: DateTime.parse(json['receivedAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }
}
