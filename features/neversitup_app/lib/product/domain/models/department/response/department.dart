class Department {
  Department({
     this.name,
     this.imageUrl,
     this.id,
  });

  final String? name;
  final String? imageUrl;
  final String? id;

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      name: json["name"],
      imageUrl: json["imageUrl"],
      id: json["id"],
    );
  }

  static List<Department> fromJsons(dynamic it) {
    return ((it ?? []) as List)
        .map((json) => Department(
              name: json['name'],
              imageUrl: json['imageUrl'],
              id: json['id'],
            ))
        .toList();
  }
}
