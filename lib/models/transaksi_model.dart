class TransaksiModel {
  int? id;
  String? nasabah;
  String? petugas;
  String? perjalanan;
  int? total;
  String? jenisTransaksi;
  String? status;
  String? keterangan;
  String? date;

  TransaksiModel({
    required this.id,
    required this.nasabah,
    required this.petugas,
    required this.perjalanan,
    required this.total,
    required this.jenisTransaksi,
    required this.status,
    required this.keterangan,
    required this.date,
  });

  TransaksiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nasabah = json['id_nasabah'];
    petugas = json['id_petugas'];
    perjalanan = json['id_perjalanan'];
    total = json['total'];
    jenisTransaksi = json['jenisTransaksi'];
    status = json['status'];
    keterangan = json['keterangan'];
    date = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_nasabah': nasabah,
      'id_petugas': petugas,
      'id_perjalanan': perjalanan,
      'total': total,
      'jenisTransaksi': jenisTransaksi,
      'status': status,
      'keterangan': keterangan,
      'created_at': date,
    };
  }
}
