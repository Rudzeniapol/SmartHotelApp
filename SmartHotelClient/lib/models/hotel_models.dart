class User {
  final String id;
  final String phone;
  final String name;
  final String? email;
  final String role; // 'guest' или 'admin'
  final List<Booking> bookings;

  User({
    required this.id,
    required this.phone,
    required this.name,
    this.email,
    required this.role,
    this.bookings = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      bookings: (json['bookings'] as List?)
          ?.map((b) => Booking.fromJson(b))
          .toList() ?? [],
    );
  }
}

class Room {
  final String id;
  final String number;
  final String type;
  final double price;
  final bool isSmart;
  final bool isAvailable;
  final List<String> amenities;
  final RoomStatus status;

  Room({
    required this.id,
    required this.number,
    required this.type,
    required this.price,
    required this.isSmart,
    required this.isAvailable,
    required this.amenities,
    required this.status,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      number: json['number'],
      type: json['type'],
      price: json['price'].toDouble(),
      isSmart: json['isSmart'],
      isAvailable: json['isAvailable'],
      amenities: List<String>.from(json['amenities']),
      status: RoomStatus.values.firstWhere(
        (e) => e.toString() == 'RoomStatus.${json['status']}',
      ),
    );
  }
}

class Booking {
  final String id;
  final String userId;
  final String roomId;
  final DateTime checkIn;
  final DateTime checkOut;
  final BookingStatus status;
  final String? accessToken;

  Booking({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    this.accessToken,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['userId'],
      roomId: json['roomId'],
      checkIn: DateTime.parse(json['checkIn']),
      checkOut: DateTime.parse(json['checkOut']),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${json['status']}',
      ),
      accessToken: json['accessToken'],
    );
  }
}

enum RoomStatus {
  available,
  occupied,
  maintenance,
  cleaning
}

enum BookingStatus {
  pending,
  confirmed,
  checkedIn,
  checkedOut,
  cancelled
} 