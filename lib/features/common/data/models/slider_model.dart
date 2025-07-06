class SliderModel {
  final int? id;
  final String photoPath;
  final String description;

  SliderModel({this.id, required this.photoPath, required this.description});

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'],
      photoPath: map['photo_path'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo_path': photoPath,
      'description': description,
    };
  }
}
