class UserModel {
  int? id;
  String? name;
  String? email;
  String? alamat;
  String? noHp;
  int? points;
  int? iurans;
  String? roles;
  String? profilePhotoPath;
  String? profilePhotoUrl;
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.alamat,
    required this.noHp,
    required this.points,
    required this.iurans,
    required this.roles,
    required this.profilePhotoPath,
    required this.profilePhotoUrl,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    alamat = json['alamat'];
    noHp = json['noHp'];
    points = json['points'];
    iurans = json['iurans'];
    roles = json['roles'];
    profilePhotoPath = json['profile_photo_path'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'alamat': alamat,
      'noHp': noHp,
      'points': points,
      'iurans': iurans,
      'roles': roles,
      'profile_photo_path': profilePhotoPath,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
    };
  }
}
