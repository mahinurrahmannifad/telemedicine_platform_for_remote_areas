class LocationModel {
  final int? id;
  final String name;
  final String location;

  LocationModel({this.id, required this.name, required this.location});

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'],
      name: map['name'],
      location: map['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };
  }
}
