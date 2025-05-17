class Booking {
  final String id;
  final String roomNumber;
  final DateTime checkIn;
  final DateTime checkOut;
  final bool isCheckedIn;
  final bool isCheckedOut;

  Booking({
    required this.id,
    required this.roomNumber,
    required this.checkIn,
    required this.checkOut,
    this.isCheckedIn = false,
    this.isCheckedOut = false,
  }) {
    if (checkOut.isBefore(checkIn)) {
      throw ArgumentError('Дата выезда не может быть раньше даты заезда');
    }
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    try {
      return Booking(
        id: json['id'] as String,
        roomNumber: json['roomNumber'] as String,
        checkIn: DateTime.parse(json['checkIn'] as String),
        checkOut: DateTime.parse(json['checkOut'] as String),
        isCheckedIn: json['isCheckedIn'] as bool? ?? false,
        isCheckedOut: json['isCheckedOut'] as bool? ?? false,
      );
    } catch (e) {
      throw FormatException('Ошибка при парсинге JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'isCheckedIn': isCheckedIn,
      'isCheckedOut': isCheckedOut,
    };
  }

  Booking copyWith({
    String? id,
    String? roomNumber,
    DateTime? checkIn,
    DateTime? checkOut,
    bool? isCheckedIn,
    bool? isCheckedOut,
  }) {
    return Booking(
      id: id ?? this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
      isCheckedOut: isCheckedOut ?? this.isCheckedOut,
    );
  }

  bool get isActive => isCheckedIn && !isCheckedOut;
  bool get isCompleted => isCheckedOut;
  bool get isPending => !isCheckedIn && !isCheckedOut;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Booking &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          roomNumber == other.roomNumber &&
          checkIn == other.checkIn &&
          checkOut == other.checkOut &&
          isCheckedIn == other.isCheckedIn &&
          isCheckedOut == other.isCheckedOut;

  @override
  int get hashCode =>
      id.hashCode ^
      roomNumber.hashCode ^
      checkIn.hashCode ^
      checkOut.hashCode ^
      isCheckedIn.hashCode ^
      isCheckedOut.hashCode;

  @override
  String toString() {
    return 'Booking(id: $id, roomNumber: $roomNumber, checkIn: $checkIn, checkOut: $checkOut, isCheckedIn: $isCheckedIn, isCheckedOut: $isCheckedOut)';
  }
}