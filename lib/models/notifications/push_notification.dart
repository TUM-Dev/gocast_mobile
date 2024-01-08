class PushNotification {
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime receivedAt;

  PushNotification({
    required this.title,
    required this.body,
    required this.data,
    required this.receivedAt,
  });

  factory PushNotification.fromJson(Map<String, dynamic> json) {
    return PushNotification(
      title: json['title'],
      body: json['body'],
      data: json['data'],
      receivedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'data': data,
      'received_at': receivedAt,
    };
  }
}
