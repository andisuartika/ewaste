class ArticleModel {
  int? id;
  String? image;
  String? title;
  String? desc;
  String? url;

  ArticleModel({
    required this.id,
    required this.image,
    required this.url,
    required this.title,
    required this.desc,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['cover'];
    title = json['title'];
    desc = json['description'];
    url = json['link'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cover': image,
      'title': title,
      'description': desc,
      'link': url,
    };
  }
}
