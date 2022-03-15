class Stock {
  Stock({
    required this.campus,
    required this.stock,
    this.id,
  });

  String? id;
  String campus;
  int stock;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        campus: json["campus"],
        stock: json["stock"],
        id: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "campus": campus,
        "stock": stock,
        "id": id ?? "",
      };
}
