class NasabahModel {
  int? id;
  String? name;
  String? email;
  String? alamat;
  String? noHp;
  String? profilePhotoPath;
  String? profilePhotoUrl;

  NasabahModel({
    required this.id,
    required this.name,
    required this.email,
    required this.alamat,
    required this.noHp,
    required this.profilePhotoPath,
    required this.profilePhotoUrl,
  });

  NasabahModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    alamat = json['alamat'];
    noHp = json['noHp'];
    profilePhotoPath = json['profile_photo_path'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'alamat': alamat,
      'noHp': noHp,
      'profile_photo_path': profilePhotoPath,
      'profile_photo_url': profilePhotoUrl,
    };
  }
}
