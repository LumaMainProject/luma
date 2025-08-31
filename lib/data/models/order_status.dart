enum OrderStatus {
  processing, // В обработке
  shipping, // Доставка
  delivered, // Доставлен
  returned, // Возвраты
}

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.processing:
        return "В обработке";
      case OrderStatus.shipping:
        return "Доставка";
      case OrderStatus.delivered:
        return "Доставлен";
      case OrderStatus.returned:
        return "Возвраты";
    }
  }

  static OrderStatus fromString(String value) {
    switch (value) {
      case 'processing':
        return OrderStatus.processing;
      case 'delivery':
        return OrderStatus.shipping;
      case 'delivered':
        return OrderStatus.delivered;
      case 'returned':
        return OrderStatus.returned;
      default:
        return OrderStatus.processing;
    }
  }
}
