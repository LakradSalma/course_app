class Course {
  final String id; // Assurez-vous que id est un String
  final String title;
  final String code;
  final String description;
  final int ects; // Assurez-vous que ects est un int

  Course({
    required this.id,
    required this.title,
    required this.code,
    required this.description,
    required this.ects,
  });

  // Méthode pour convertir un JSON en un objet Course
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'].toString(), // Assurez-vous que l'ID est traité comme une chaîne de caractères
      title: json['title'],
      code: json['code'],
      description: json['description'],
      ects: json['ects'],
    );
  }
}
