class UserModel {
  UserModel({
    this.id,
    required this.address,
    required this.role,
    required this.phone,
    required this.campus,
    required this.name,
    required this.email,
    required this.status,
  });
  String? id;
  String address;
  String role;
  String phone;
  String campus;
  String name;
  String email;
  bool status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? "",
        address: json["address"],
        role: json["role"],
        phone: json["phone"],
        campus: json["campus"],
        name: json["name"],
        email: json["email"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "address": address,
        "role": role,
        "phone": phone,
        "campus": campus,
        "name": name,
        "email": email,
        "status": status,
      };
}
