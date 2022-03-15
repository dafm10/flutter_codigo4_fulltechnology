import 'package:flutter_codigo4_fulltechnology/models/product_sale_model.dart';

class SaleModel {
  String? id;
  String datetme;
  double discount;
  String idCampus;
  String idSeller;
  String customer;
  List<ProductSaleModel> products;
  double total;

  SaleModel({
    this.id,
    required this.datetme,
    required this.discount,
    required this.idCampus,
    required this.idSeller,
    required this.customer,
    required this.products,
    required this.total,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        id: json['id'] ?? "",
        datetme: json['datetme'],
        discount: json['discount'],
        idCampus: json['idCampus'],
        idSeller: json['idSeller'],
        customer: json['customer'],
        products: json['products'] != null
            ? List<ProductSaleModel>.from(
                json['products'].map((x) => ProductSaleModel.fromJson(x)))
            : [],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'datetme': datetme,
        'discount': discount,
        'idCampus': idCampus,
        'idSeller': idSeller,
        'customer': customer,
        'products': List<dynamic>.from(products.map((e) => e.toJson())),
        'total': total,
      };
}
