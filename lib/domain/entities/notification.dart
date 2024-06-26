class NotificationEntity {
  String? title;
  int? customerId;
  DateTime? time;
  String? content;
  String? category;

  NotificationEntity({this.time, this.category, this.content, this.title});
  static List<NotificationEntity> notis = [];
}
