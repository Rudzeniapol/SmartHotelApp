class Device {
  final String id;
  final String name;
  final String type;
  final bool isConnected;
  final bool isOn;
  final double? temperature;
  final double? humidity;

  Device({
    required this.id,
    required this.name,
    required this.type,
    this.isConnected = false,
    this.isOn = false,
    this.temperature,
    this.humidity,
  });

  Device copyWith({
    String? id,
    String? name,
    String? type,
    bool? isConnected,
    bool? isOn,
    double? temperature,
    double? humidity,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      isConnected: isConnected ?? this.isConnected,
      isOn: isOn ?? this.isOn,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
    );
  }
} 