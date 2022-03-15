import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_fulltechnology/models/product_model.dart';
import 'package:flutter_codigo4_fulltechnology/models/stock_model.dart';
import 'package:flutter_codigo4_fulltechnology/pages/admin/product_form_page.dart';
import 'package:flutter_codigo4_fulltechnology/services/firebase_service.dart';
import 'package:flutter_codigo4_fulltechnology/ui/general/colors.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/alert_delete_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/alert_stock_form_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/button_primary_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/general_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/header_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/item_list_widget.dart';
import 'package:flutter_codigo4_fulltechnology/ui/widget/message_empty_widget.dart';
import 'package:flutter_svg/svg.dart';

class WarehouseListAdminPage extends StatelessWidget {
  final String collection;
  final String title;
  final String title2;

  WarehouseListAdminPage({
    required this.collection,
    required this.title,
    required this.title2,
  });

  ProductModel? productModel;
  late final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(collection);

  final FirebaseService _productService =
      FirebaseService(collection: 'products');

  List<Stock> stockList = [];
  int stockTotal = 0;

  // alternativa para agregar con id manual - codigo de barras
  // register() {
  //   _collectionReference.doc("asdasd").set({"campo": "sadasda"});
  // }

  showDeleteForm(BuildContext context) {
    showDialog(
      barrierColor: COLOR_BRAND_PRIMARY.withOpacity(0.6),
      context: context,
      builder: (context) {
        return AlertDeleteWidget(
          onDelete: () {
            _productService.deleteItem(productModel!.id!).then((value) {
              if (value == 1) {
                Navigator.pop(context);
                //Mostrar un mensaje de éxito.
                messageSuccessSnackBar(context, 0);
              }
            }).catchError(
              (error) {
                print(error);
              },
            );
          },
        );
      },
    );
  }

  showStockForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: COLOR_BRAND_PRIMARY.withOpacity(0.5),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AlertStockFormWidget(
            productModel: productModel!,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_BRAND_PRIMARY,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: COLOR_BRAND_PRIMARY,
        onPressed: () {
          //register();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(title: title),
            const SizedBox(
              height: 12.0,
            ),
            StreamBuilder(
              stream: _collectionReference
                  .orderBy('description', descending: false)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  QuerySnapshot collection = snap.data;
                  //print(collection.docs.first.data());
                  List<ProductModel> products =
                      collection.docs.map<ProductModel>((e) {
                    ProductModel product = ProductModel.fromJson(
                      e.data() as Map<String, dynamic>,
                    );
                    product.id = e.id;
                    return product;
                  }).toList();

                  return products.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // stockList = products[index].stock;
                                // stockTotal = products[index].stockTotal;
                                //productModel ? products[index];
                                productModel = products[index];
                                showStockForm(context);
                              },
                              child: ItemListWidget(
                                title: products[index].description,
                                price: products[index].price,
                                stock: products[index].stockTotal,
                                onDelete: () {
                                  productModel = products[index];
                                  showDeleteForm(context);
                                },
                                onEdit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductFormPage(
                                        productModel: products[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : const MessageEmptyWidget();
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
