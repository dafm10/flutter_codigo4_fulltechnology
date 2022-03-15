import 'package:flutter_codigo4_fulltechnology/models/stock_model.dart';

class ProductModel {
  String? id;
  String size;
  double price;
  int stockTotal;
  String specification;
  String description;
  String model;
  String category;
  List<Stock> stock;
  String brand;

  ProductModel({
    this.id,
    required this.size,
    required this.price,
    required this.stockTotal,
    required this.specification,
    required this.description,
    required this.model,
    required this.category,
    required this.stock,
    required this.brand,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? "",
        size: json["size"],
        price: json["price"].toDouble(),
        stockTotal: json["stock_total"],
        specification: json["specification"],
        description: json["description"],
        model: json["model"],
        category: json["category"],
        stock: List<Stock>.from(json["stock"].map((x) => Stock.fromJson(x))),
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "size": size,
        "price": price,
        "stock_total": stockTotal,
        "specification": specification,
        "description": description,
        "model": model,
        "category": category,
        "stock": List<dynamic>.from(stock.map((x) => x.toJson())),
        "brand": brand,
      };
}
