import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_sale_model.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/login_admin_page.dart';
import 'package:flutter_codigo4_fulltechnology/pages/seller/shopping_page.dart';
import 'package:flutter_codigo4_fulltechnology/provider/shopping_provider.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/header_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/item_list_seller_widget.dart';
import 'package:flutter_codigo4_fulltechnology/utils/sp_global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SalePage extends StatelessWidget {
  final CollectionReference _productReference =
      FirebaseFirestore.instance.collection('products');
  SPGlobal prefs = SPGlobal();

  @override
  Widget build(BuildContext context) {
    final ShoppingProvider shoppingProvider =
        Provider.of<ShoppingProvider>(context);

    // print(shoppingProvider.productLength);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_BRAND_PRIMARY,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingPage(),
                ),
              );
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  'assets/icons/shopping-cart.svg',
                  height: 20.0,
                  color: Colors.white,
                ),
                shoppingProvider.productLength > 0
                    ? Positioned(
                        right: -8,
                        top: -7,
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          padding: const EdgeInsets.all(1.0),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            shoppingProvider.productLength < 99
                                ? shoppingProvider.productLength.toString()
                                : "99",
                          ),
                        ),
                      )
                    : Positioned(
                        right: -8,
                        top: -7,
                        child: Container(),
                      ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              prefs.userName = "";
              prefs.campusId = "";
              prefs.isLogin = "";
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginAdminPage(),
                  ),
                  (route) => false);
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(title: "Productos"),
              const SizedBox(
                height: 12.0,
              ),
              StreamBuilder(
                stream: _productReference.snapshots(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    QuerySnapshot collection = snap.data;
                    List<ProductModel> products =
                        collection.docs.map<ProductModel>(
                      (e) {
                        ProductModel product = ProductModel.fromJson(
                          e.data() as Map<String, dynamic>,
                        );
                        product.id = e.id;
                        return product;
                      },
                    ).toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ItemListSellerWidget(
                          title: products[index].description,
                          stock: products[index]
                              .stock
                              .where((element) => element.id == prefs.campusId)
                              .toList()
                              .first
                              .stock,
                          onAddShopping: () {
                            ProductSaleModel productSaleModel =
                                ProductSaleModel(
                              idProduct: products[index].id!,
                              price: products[index].price,
                              product: products[index].description,
                              quantity: 1,
                            );
                            shoppingProvider.addProduct(productSaleModel);
                          },
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
