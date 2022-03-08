class SampahModel {
  int? id;
  String? nama;
  String? harga;
  String? tentang;
  String? pengelolaan;
  String? image;

  SampahModel({
    required this.id,
    required this.nama,
    required this.harga,
    required this.tentang,
    required this.pengelolaan,
    required this.image,
  });

  SampahModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    harga = json['harga'];
    tentang = json['tentang'];
    pengelolaan = json['pengelolaan'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'tentang': tentang,
      'pengelolaan': pengelolaan,
      'image': image,
    };
  }
}
