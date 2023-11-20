class Purchase {
  final String orderId;
  final String productName;
  final double price;
  final DateTime purchaseDate;

  Purchase({
    required this.orderId,
    required this.productName,
    required this.price,
    required this.purchaseDate,
  });
}
