class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String qualification;
  final String imageUrl;
  final double rating;
  final String workingTime;
  final int consultationFee;
  final String experience;
  final String about;
  final bool isOnline;
  final DateTime createdAt;
  final DateTime updatedAt;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.qualification,
    required this.imageUrl,
    required this.rating,
    required this.workingTime,
    required this.consultationFee,
    required this.experience,
    required this.about,
    this.isOnline = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'qualification': qualification,
      'imageUrl': imageUrl,
      'rating': rating,
      'workingTime': workingTime,
      'consultationFee': consultationFee,
      'experience': experience,
      'about': about,
      'isOnline': isOnline ? 1 : 0,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      specialty: map['specialty'] ?? '',
      qualification: map['qualification'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      workingTime: map['workingTime'] ?? '',
      consultationFee: map['consultationFee'] ?? 0,
      experience: map['experience'] ?? '',
      about: map['about'] ?? '',
      isOnline: (map['isOnline'] ?? 0) == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
    );
  }

  Doctor copyWith({
    String? id,
    String? name,
    String? specialty,
    String? qualification,
    String? imageUrl,
    double? rating,
    String? workingTime,
    int? consultationFee,
    String? experience,
    String? about,
    bool? isOnline,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      qualification: qualification ?? this.qualification,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      workingTime: workingTime ?? this.workingTime,
      consultationFee: consultationFee ?? this.consultationFee,
      experience: experience ?? this.experience,
      about: about ?? this.about,
      isOnline: isOnline ?? this.isOnline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}