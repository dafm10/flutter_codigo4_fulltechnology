class ProductSaleModel {
  String idProduct;
  double price;
  String product;
  int quantity;

  ProductSaleModel({
    required this.idProduct,
    required this.price,
    required this.product,
    required this.quantity,
  });

  factory ProductSaleModel.fromJson(Map<String, dynamic> json) =>
      ProductSaleModel(
        idProduct: json["id_product"],
        price: json["price"].toDouble(),
        product: json["product"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id_product": idProduct,
        "price": price,
        "product": product,
        "quantity": quantity,
      };
}
