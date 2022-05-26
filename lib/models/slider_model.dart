class SliderModel {
  int? id;
  String? image;
  String? url;

  SliderModel({
    required this.id,
    required this.image,
    required this.url,
  });

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['gambar'];
    url = json['link'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gambar': image,
      'link': url,
    };
  }
}
