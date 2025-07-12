class SliderModel {
  final int? id;
  final String assetPath;

  SliderModel({this.id, required this.assetPath});

  Map<String, dynamic> toMap() => {
    'id': id,
    'asset_path': assetPath,
  };

  factory SliderModel.fromMap(Map<String, dynamic> map) => SliderModel(
    id: map['id'],
    assetPath: map['asset_path'],
  );
}
