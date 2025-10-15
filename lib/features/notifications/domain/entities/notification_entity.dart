import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String? title;
  final String? body;
  final Map<String, dynamic> dataPayload;
  final DateTime receivedAt;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.dataPayload,
    required this.receivedAt,
    this.isRead = false,
  });

  @override
  List<Object?> get props {
    return [id, title, body, dataPayload, receivedAt, isRead];
  }
}
