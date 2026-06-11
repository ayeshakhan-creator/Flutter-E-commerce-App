class Order {
  final String id;
  final double amount;
  final List items;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.items,
    required this.dateTime,
  });
}