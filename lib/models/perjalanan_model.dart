class PerjalananModel {
  int? id;
  String? kode;
  String? waktuTugas;
  String? waktuSelesai;
  String? keterangan;
  String? status;

  PerjalananModel({
    required this.id,
    required this.kode,
    required this.waktuTugas,
    required this.waktuSelesai,
    required this.keterangan,
    required this.status,
  });

  PerjalananModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    waktuTugas = json['waktuTugas'];
    waktuSelesai = json['waktuSelesai'];
    keterangan = json['keterangan'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode': kode,
      'waktuTugas': waktuTugas,
      'waktuSelesai': waktuSelesai,
      'status': status,
    };
  }
}
