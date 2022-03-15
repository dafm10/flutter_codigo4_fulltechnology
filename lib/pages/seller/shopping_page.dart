import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_sale_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/sale_model.dart';
import 'package:flutter_codigo4_fulltechnology/provider/shopping_provider.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/general_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/item_list_shopping_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/textfield_normal_widget.dart';
import 'package:flutter_codigo4_fulltechnology/utils/sp_global.dart';
import 'package:provider/provider.dart';

class ShoppingPage extends StatelessWidget {
  final DateTime dateTime = DateTime.now();
  List<ProductSaleModel> products = [];
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final FirebaseService _saleService = FirebaseService(collection: 'sales');
  SPGlobal prefs = SPGlobal();
  double total = 0;

  register(BuildContext context) {
    SaleModel saleModel = SaleModel(
      datetme: dateTime.toString(),
      discount: double.parse(_discountController.text),
      idCampus: prefs.campusId,
      idSeller: prefs.sellerId,
      customer: _customerController.text,
      products: products,
      total: total,
    );
    _saleService.addSale(saleModel).then((value) {
      if (value.isNotEmpty) {
        messageSuccessSnackBar(context, 2);

        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ShoppingProvider shoppingProvider =
        Provider.of<ShoppingProvider>(context);
    // print("XXXXXXX ${shoppingProvider.productLength}");
    // print("XXXXXXX ${shoppingProvider.getProduct}");
    // print(shoppingProvider.total);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_BRAND_PRIMARY,
        elevation: 0,
        title: const Text("Detalle de la venta"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Fecha: ",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(dateTime.toString().split(" ")[0]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10.0,
                  ),
                  child: TextFieldNormalWidget(
                    hintText: "Descuento",
                    icon: "money",
                    isNumeric: true,
                    textInputType: TextInputType.number,
                    controller: _discountController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                  ),
                  child: TextFieldNormalWidget(
                    hintText: "Nombre Cliente",
                    icon: "user",
                    controller: _customerController,
                  ),
                ),
                const Divider(
                  indent: 14.0,
                  endIndent: 14.0,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text(
                  "Productos seleccionados",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: shoppingProvider.productLength,
                  itemBuilder: (context, index) {
                    ProductSaleModel productSaleModel =
                        shoppingProvider.getProduct[index];
                    return ItemListShoppingWidget(
                      title: productSaleModel.product,
                      quantity: productSaleModel.quantity,
                      price: productSaleModel.price,
                      onDelete: () {
                        shoppingProvider.deleteProduct(index);
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30.0),
              height: 54.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff7f77e0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  "Total: ${shoppingProvider.total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  products = shoppingProvider.getProduct;
                  total = shoppingProvider.total;
                  register(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
