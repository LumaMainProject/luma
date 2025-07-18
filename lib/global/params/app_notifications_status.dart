enum AppNotificationsStatus {
  await,
  confirmed,
  inDelivery,
  canseled,
  delivered,
}

abstract class AppNotificationsStatusMap{
  static final Map<AppNotificationsStatus, String> appNotificationsStatusMap = {
    AppNotificationsStatus.await : "Ожидание",
    AppNotificationsStatus.confirmed : "Заказ одобрен",
    AppNotificationsStatus.inDelivery : "В пути",
    AppNotificationsStatus.canseled : "Отменен",
    AppNotificationsStatus.delivered : "Доставлен",
  };
}