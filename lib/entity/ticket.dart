class Ticket {
  final String? id;
  final String idUser;
  final String hashTicket;
  final double ticketPrice;

  Ticket(
      {this.id,
      required this.idUser,
      required this.hashTicket,
      required this.ticketPrice}
  );
}

// class Destinasi {
//   final String? id;
//   final String destinationName;
//   final String destinationAddress;
//   final String destinationDescription;
//   final double destinationLatitude;
//   final double destinationLongitude;
//   final String destinationImage;
//   final String destinationCategory;
//   final int destinationRating;

//   Destinasi(
//       {this.id,
//       required this.destinationName,
//       required this.destinationAddress,
//       required this.destinationDescription,
//       required this.destinationLatitude,
//       required this.destinationLongitude,
//       required this.destinationImage,
//       required this.destinationCategory,
//       required this.destinationRating}
//   );

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'destinationName': destinationName,
//     'destinationAddress': destinationAddress,
//     'destinationDescription': destinationDescription,
//     'destinationLatitude': destinationLatitude,
//     'destinationLongitude': destinationLongitude,
//     'destinationImage': destinationImage,
//     'destinationCategory': destinationCategory,
//     'destinationRating': destinationRating,
//   };

//   static Destinasi fromJson(Map<String, dynamic> json) => Destinasi(
//       id: json['id'],
//       destinationName: json['destinationName'],
//       destinationAddress: json['destinationAddress'],
//       destinationDescription: json['destinationDescription'],
//       destinationLatitude: json['destinationLatitude'],
//       destinationLongitude: json['destinationLongitude'],
//       destinationImage: json['destinationImage'],
//       destinationCategory: json['destinationCategory'],
//       destinationRating: json['destinationRating'],
//   );
// }