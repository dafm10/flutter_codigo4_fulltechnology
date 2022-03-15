class GeneralModel {
  GeneralModel({
    this.id,
    required this.description,
    required this.status,
  });

  String? id;
  String description;
  bool status;

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
        id: json["id"] ?? "",
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "status": status,
      };
}
