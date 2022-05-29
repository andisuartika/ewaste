class TabunganModel {
  String? tabungan;
  String? ditarik;
  String? organik;
  String? plastik;
  String? kertas;
  String? logam;
  String? kaca;

  TabunganModel({
    required this.tabungan,
    required this.ditarik,
    required this.organik,
    required this.plastik,
    required this.kertas,
    required this.logam,
    required this.kaca,
  });

  TabunganModel.fromJson(Map<String, dynamic> json) {
    tabungan = json['tabungan'];
    ditarik = json['ditarik'];
    organik = json['sampah']['organik'];
    plastik = json['sampah']['plastik'];
    kertas = json['sampah']['kertas'];
    logam = json['sampah']['logam'];
    kaca = json['sampah']['kaca'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tabungan': tabungan,
      'ditarik': ditarik,
      'organik': organik,
      'plastik': plastik,
      'kertas': kertas,
      'logam': logam,
      'kaca': kaca,
    };
  }
}
