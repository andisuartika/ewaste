class NotificationModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? date;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    date = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'created_at': date,
    };
  }
}
