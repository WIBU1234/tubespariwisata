import 'dart:convert';

class Ticket {
  int? id;
  int idDestination;
  String ticketName;
  String status;
  int quantity;
  double price;

  Ticket({
    this.id,
    required this.idDestination,
    required this.ticketName,
    required this.status,
    required this.quantity,
    required this.price,
  });

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));
  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"] ?? 0,
    idDestination: json["idDestination"],
    ticketName: json["ticketName"],
    status: json["status"],
    quantity: json["quantity"],
    price: (json["price"] as num).toDouble(),
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "idDestination": idDestination,
    "ticketName": ticketName,
    "status": status,
    "quantity": quantity,
    "price": price,
  };
}