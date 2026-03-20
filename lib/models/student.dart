class Student {
  final String id;
  final String name;
  final String className;
  final String major;
  final double gpa;

  Student({
    required this.id,
    required this.name,
    required this.className,
    required this.major,
    required this.gpa,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'className': className,
      'major': major,
      'gpa': gpa,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      className: json['className'],
      major: json['major'],
      gpa: (json['gpa'] as num).toDouble(),
    );
  }

  Student copyWith({
    String? name,
    String? className,
    String? major,
    double? gpa,
  }) {
    return Student(
      id: id,
      name: name ?? this.name,
      className: className ?? this.className,
      major: major ?? this.major,
      gpa: gpa ?? this.gpa,
    );
  }
}
