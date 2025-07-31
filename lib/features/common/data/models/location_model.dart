class LocationModel {
  final int id;
  final String name;
  final String location;

  LocationModel({
    this.id = 1, // default ID
    required this.name,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] ?? 1,
      name: map['name'],
      location: map['location'],
    );
  }
}
