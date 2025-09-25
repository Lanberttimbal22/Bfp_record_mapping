class Establishment {
  final String id;
  String name;
  String address;
  String type;
  DateTime establishedDate;
  double? latitude; // <-- New field
  double? longitude; // <-- New field

  // Default constructor
  Establishment({
    required this.id,
    required this.name,
    required this.address,
    required this.type,
    required this.establishedDate,
    this.latitude,
    this.longitude,
  });

  // Named constructor for creation (with optional location)
  Establishment.create({
    required this.name,
    required this.address,
    required this.type,
    this.latitude,
    this.longitude,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString(),
       establishedDate = DateTime.now();

  // Convert to Map for DB or JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'type': type,
      'establishedDate': establishedDate.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Create from Map (e.g. from DB or API)
  factory Establishment.fromMap(Map<String, dynamic> map) {
    return Establishment(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      type: map['type'],
      establishedDate: DateTime.parse(map['establishedDate']),
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
    );
  }
}
