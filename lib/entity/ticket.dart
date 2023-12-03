import 'dart:convert';

class Ticket {
  int? id;
  String ticketName;
  String status;
  int quantity;
  double ticketPrice;

  Ticket({
    this.id,
    required this.ticketName,
    required this.status,
    required this.quantity,
    required this.ticketPrice,
  });

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));
  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"] ?? 0,
    ticketName: json["ticketName"],
    status: json["status"],
    quantity: json["quantity"],
    ticketPrice: (json["ticketPrice"] as num).toDouble(),
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "ticketName": ticketName,
    "status": status,
    "quantity": quantity,
    "ticketPrice": ticketPrice,
  };
}