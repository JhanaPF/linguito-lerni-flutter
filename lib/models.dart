class CourseModel {
  final String id;
  final String language;
  final String pivotLanguage;
  final String rawName;
  final bool dictionary;
  final String fileName;
  final bool released;
  final DateTime? createdAt;

  CourseModel({
    required this.id,
    required this.language,
    required this.pivotLanguage,
    required this.rawName,
    required this.dictionary,
    required this.fileName,
    required this.released,
    this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    //print(json);
    return CourseModel(
      id: json['_id'].toString(),
      language: json['language'],
      pivotLanguage: json['pivot_language'],
      rawName: json['raw_name'],
      dictionary: json['dictionary'],
      fileName: json['file_name'],
      released: json['released'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

    // Override the toString() method
  @override
  String toString() {
    return 'Person{language: $language, pivotLanguage: $pivotLanguage}';
  }
}
