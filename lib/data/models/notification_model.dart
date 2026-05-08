class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final bool isRead;
  final String promotionId; 


  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    this.isRead = false,
    required this.promotionId,
  });
}
