import 'package:flutter_product_detail_app/data/models/notification_model.dart';

final List<NotificationModel> sampleNotifications = [
  NotificationModel(
    id: '1',
    title: 'ប្រមូលថ្មី 2k26',
    description:
        'បញ្ចុះតំលៃ ទោល់ស្រប់គ្រប់ផលិតផល Skincare និង Make Up ទូទាំងហាង',
    imageUrl:
        'https://i.pinimg.com/1200x/fd/aa/7f/fdaa7fe74da171cf69171ff7b9c9c132.jpg',
    date: DateTime(2026, 1, 11),
    promotionId: 'promo_2', // Flash Sale poster ← matches
  ),
  NotificationModel(
    id: '2',
    title: 'Fillimilli',
    description: 'ផលិតផលថ្មី Fillimilli',
    imageUrl:
        'https://i.pinimg.com/1200x/d2/4c/b1/d24cb121be5e236c041fc71b4d24d69c.jpg',
    date: DateTime(2025, 12, 27),
    promotionId: 'promo_3', // Romand Make Up poster ← matches
  ),
  NotificationModel(
    id: '3',
    title: '3CE',
    description: 'ថ្មីទៀង + ជួលសម្អេដ្ឋទាក់ 3CE',
    imageUrl:
        'https://i.pinimg.com/736x/c3/14/da/c314daeb45bf7d9d5852924ef791baba.jpg',
    date: DateTime(2025, 12, 20),
    promotionId: 'promo_4', // Restock & New Arrival poster ← matches
  ),
  NotificationModel(
    id: '4',
    title: 'Skin 1004',
    description: 'បន្ថែម 10% ថ្មីលំទាក់ Skin 1004',
    imageUrl:
        'https://i.pinimg.com/1200x/89/1e/dc/891edc527a7b0bad5ce6220ef1823727.jpg',
    date: DateTime(2025, 12, 15),
    promotionId: 'promo_1', // Skin1004 Brand Sale poster ← matches
  ),
];
