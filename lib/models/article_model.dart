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
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'desc': desc,
      'url': url,
    };
  }
}
