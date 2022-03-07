class SampahModel {
  int? id;
  String? nama;
  int? harga;
  String? tentang;
  String? pengelolaan;

  SampahModel({
    required this.id,
    required this.nama,
    required this.harga,
    required this.tentang,
    required this.pengelolaan,
  });

  SampahModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    harga = json['harga'];
    tentang = json['tentang'];
    pengelolaan = json['pengelolaan'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'tentang': tentang,
      'pengelolaan': pengelolaan,
    };
  }
}
