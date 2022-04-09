class BankModel {
  int? id;
  String? name;
  String? type;
  String? image;

  BankModel({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
  });

  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'image': image,
    };
  }
}
