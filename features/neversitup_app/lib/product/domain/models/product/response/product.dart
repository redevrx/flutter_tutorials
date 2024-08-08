class Product {
  String? name;
  String? imageUrl;
  String? desc;
  String? price;
  String? type;
  String? id;
  String? departmentId;

  Product({
    this.name,
    this.imageUrl,
    this.desc,
    this.price,
    this.type,
    this.id,
    this.departmentId,
  });

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    desc = json['desc'];
    price = json['price'];
    type = json['type'];
    id = json['id'];
    departmentId = json['departmentId'];
  }

  static List<Product> fromJsons(dynamic it) {
    return ((it ?? []) as List)
        .map((json) => Product(
              name: json['name'],
              imageUrl: json['imageUrl'],
              desc: json['desc'],
              price: json['price'],
              type: json['type'],
              id: json['id'],
              departmentId: json['departmentId'],
            ))
        .toList();
  }

  Map<String, dynamic> get toJson {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['desc'] = desc;
    data['price'] = price;
    data['type'] = type;
    data['id'] = id;
    data['departmentId'] = departmentId;
    return data;
  }
}
